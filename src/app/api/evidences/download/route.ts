// app/api/download/route.ts
import { NextRequest, NextResponse } from "next/server";
import ExcelJS from "exceljs";
import { query } from "@/app/lib/postgres";

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
    const start_date = searchParams.get("start_date");
    const end_date = searchParams.get("end_date");

    if (!start_date || !end_date) {
      return NextResponse.json(
        { error: "Missing start_date or end_date" },
        { status: 400 }
      );
    }

    // ============================
    // Ambil semua data evidence + join user name
    // ============================
    const result = await query<EvidenceRow>(
      "SELECT e.id, e.user_email, e.content_id, e.evidence_title, e.evidence_description, e.evidence_date, e.evidence_status, e.completion_proof, e.created_at, e.evidence_job, u.name AS user_name, c.content_title AS content_title FROM evidence e LEFT JOIN users u ON u.email = e.user_email LEFT JOIN content c ON c.id = e.content_id WHERE e.evidence_date >= $1 AND e.evidence_date <= $2 ORDER BY e.evidence_date ASC",
      [start_date, end_date]
    );

    const data = result.rows;

    if (!data || data.length === 0) {
      return NextResponse.json({ error: "No data found" }, { status: 404 });
    }

    // ============================
    // Inisialisasi workbook Excel
    // ============================
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet("Evidence Report");

    // ========================
    // Judul & Date Range
    // ========================
    worksheet.mergeCells("A1:D1");
    const titleCell = worksheet.getCell("A1");
    titleCell.value = "Evidence Report (All Users)";
    titleCell.font = { bold: true, size: 14 };
    titleCell.alignment = { horizontal: "center" };

    worksheet.addRow([
      `Date Range: ${formatDate(start_date)} to ${formatDate(end_date)}`,
    ]).font = { size: 11 };
    worksheet.addRow([]); // spasi kosong

    // ========================
    // TABLE USER
    // ========================
    const userHeader = ["User Name", "Total Evidence", "Accepted Evidence"];
    const userHeaderRow = worksheet.addRow(userHeader);
    styleHeaderRow(userHeaderRow);

    const groupedByUser: Record<string, { total: number; accepted: number }> =
      {};

    data.forEach((row: EvidenceRow) => {
      const userName = row.user_name ?? row.user_email ?? "Unknown User";
      if (!groupedByUser[userName]) {
        groupedByUser[userName] = { total: 0, accepted: 0 };
      }
      groupedByUser[userName].total++;
      if (row.evidence_status === "accepted") {
        groupedByUser[userName].accepted++;
      }
    });

    Object.entries(groupedByUser).forEach(([name, stats]) => {
      const newRow = worksheet.addRow([name, stats.total, stats.accepted]);
      styleDataRow(newRow);
    });

    worksheet.addRow([]); // spasi kosong

    // ========================
    // HISTORY KESELURUHAN
    // ========================
    const historyTitleCell = worksheet.addRow([`History Evidence Keseluruhan`]);
    historyTitleCell.font = { bold: true, size: 13 };
    worksheet.addRow([]);

    const historyHeader = [
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
    const historyHeaderRow = worksheet.addRow(historyHeader);
    styleHeaderRow(historyHeaderRow);

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
      styleDataRow(newRow);
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
        "Content-Disposition": `attachment; filename="evidence_all_users_${start_date}_${end_date}.xlsx"`,
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

// ========================
// Helper Style
// ========================
function styleHeaderRow(row: ExcelJS.Row) {
  row.font = { bold: true, size: 11 };
  row.alignment = { horizontal: "center", vertical: "middle" };
  row.eachCell((cell) => {
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
}

function styleDataRow(row: ExcelJS.Row) {
  row.alignment = { vertical: "top", wrapText: true };
  row.eachCell((cell) => {
    cell.border = {
      top: { style: "thin" },
      left: { style: "thin" },
      bottom: { style: "thin" },
      right: { style: "thin" },
    };
  });
}

function formatDate(dateStr?: string | null) {
  if (!dateStr) return "";
  return new Date(dateStr).toISOString().split("T")[0];
}
