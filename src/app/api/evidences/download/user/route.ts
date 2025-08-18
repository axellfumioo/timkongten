// app/api/download/route.ts
import { NextRequest, NextResponse } from "next/server";
import { supabase } from "@/app/lib/supabase";
import ExcelJS from "exceljs";

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

    // Ambil data dari Supabase
    const { data, error } = await supabase
      .from("evidence")
      .select("*")
      .eq("user_email", user)
      .gte("evidence_date", start_date)
      .lte("evidence_date", end_date)
      .order("evidence_date", { ascending: true });

    if (error) {
      console.error(error);
      return NextResponse.json(
        { error: "Failed to fetch data from Supabase" },
        { status: 500 }
      );
    }

    const totalEvidence = data.length;
    const acceptedCount = data.filter(
      (ev) => ev.evidence_status === "accepted"
    ).length;

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
    worksheet.addRow([`User: ${user}`]).font = summaryStyle;
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
      "User Email",
      "Content ID",
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
    data.forEach((row) => {
      const newRow = worksheet.addRow([
        row.id,
        row.user_email,
        row.content_id ?? "",
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
        "Content-Disposition": `attachment; filename="evidence_${user}_${start_date}_${end_date}.xlsx"`,
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
