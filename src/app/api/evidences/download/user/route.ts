// app/api/download/route.ts
import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs";
import { query } from "@/app/lib/postgres";

// Tipe data evidence biar TypeScript gak error
type EvidenceRow = {
  id: string;
  user_email: string;
  content_id: string | null;
  evidence_title: string | null;
  evidence_description: string | null;
  evidence_date: string;
  evidence_status: string | null;
  completion_proof: string | null;
  created_at: string;
  evidence_job: string | null;
  user_name: string | null;
  content_title: string | null;
};

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const user = searchParams.get("user");
    const start_date = searchParams.get("start_date");
    const end_date = searchParams.get("end_date");

    if (!user || !start_date || !end_date) {
      return NextResponse.json(
        { error: "Missing required parameters" },
        { status: 400 }
      );
    }

    // Ambil data evidence dan join ke tabel users
    const result = await query<EvidenceRow>(
      "SELECT e.id, e.user_email, e.content_id, e.evidence_title, e.evidence_description, e.evidence_date, e.evidence_status, e.completion_proof, e.created_at, e.evidence_job, u.name AS user_name, c.content_title AS content_title FROM evidence e LEFT JOIN users u ON u.email = e.user_email LEFT JOIN content c ON c.id = e.content_id WHERE e.user_email = $1 AND e.evidence_date >= $2 AND e.evidence_date <= $3 ORDER BY e.evidence_date ASC",
      [user, start_date, end_date]
    );

    const data = result.rows;

    if (!data || data.length === 0) {
      return NextResponse.json(
        { error: "No evidence data found" },
        { status: 404 }
      );
    }

    const totalEvidence = data.length;
    const acceptedCount = data.filter(
      (ev: EvidenceRow) => ev.evidence_status === "accepted"
    ).length;

    // Ambil nama user dari hasil relasi
    const userName = data[0]?.user_name ?? user ?? "Unknown User";

    // Buat workbook & worksheet
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet("Evidence Data");

    // ========================
    // Summary
    // ========================
    worksheet.mergeCells("A1:D1");
    const titleCell = worksheet.getCell("A1");
    titleCell.value = "Evidence Report";
    titleCell.font = { bold: true, size: 14 };
    titleCell.alignment = { horizontal: "center" };

    const summaryStyle = { size: 11, bold: true };
    worksheet.addRow([`User: ${userName}`]).font = summaryStyle;
    worksheet.addRow([
      `Date Range: ${formatDate(start_date)} to ${formatDate(end_date)}`,
    ]).font = { size: 11 };
    worksheet.addRow([`Total Evidence: ${totalEvidence}`]).font = { size: 11 };
    worksheet.addRow([`Accepted Evidence: ${acceptedCount}`]).font = {
      size: 11,
    };
    worksheet.addRow([]); // spasi kosong

    // ========================
    // Header tabel
    // ========================
    const headers = [
      "ID",
      "User Name",
      "Content Name",
      "Evidence Title",
      "Evidence Description",
      "Evidence Date",
      "Evidence Status",
      "Completion Proof",
      "Created At",
      "Evidence Job",
    ];
    const headerRow = worksheet.addRow(headers);
    headerRow.font = { bold: true, size: 11 };
    headerRow.alignment = { horizontal: "center", vertical: "middle" };
    headerRow.eachCell((cell) => {
      cell.fill = {
        type: "pattern",
        pattern: "solid",
        fgColor: { argb: "FFD9D9D9" },
      };
      cell.border = {
        top: { style: "thin" },
        left: { style: "thin" },
        bottom: { style: "thin" },
        right: { style: "thin" },
      };
    });

    // ========================
    // Isi data
    // ========================
    data.forEach((row: EvidenceRow) => {
      const newRow = worksheet.addRow([
        row.id,
        row.user_name ?? row.user_email ?? "Unknown User",
        row.content_title ?? "",
        row.evidence_title ?? "",
        row.evidence_description ?? "",
        formatDate(row.evidence_date),
        row.evidence_status ?? "",
        row.completion_proof ?? "",
        formatDate(row.created_at),
        row.evidence_job ?? "",
      ]);
      newRow.alignment = { vertical: "top", wrapText: true };
      newRow.eachCell((cell) => {
        cell.border = {
          top: { style: "thin" },
          left: { style: "thin" },
          bottom: { style: "thin" },
          right: { style: "thin" },
        };
      });
    });

    // ========================
    // Auto-fit kolom
    // ========================
    worksheet.columns?.forEach((col) => {
      if (!col) return;
      let maxLength = 0;

      col.eachCell?.({ includeEmpty: true }, (cell) => {
        const cellValue = cell.value ? String(cell.value) : "";
        maxLength = Math.max(maxLength, cellValue.length);
      });

      col.width = Math.min(maxLength + 2, 50);
    });

    const buffer = await workbook.xlsx.writeBuffer();
    return new NextResponse(buffer, {
      status: 200,
      headers: {
        "Content-Disposition": `attachment; filename="evidence_${userName}_${start_date}_${end_date}.xlsx"`,
        "Content-Type":
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
      },
    });
  } catch (err) {
    console.error(err);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

function formatDate(dateStr?: string | null) {
  if (!dateStr) return "";
  return new Date(dateStr).toISOString().split("T")[0];
}
