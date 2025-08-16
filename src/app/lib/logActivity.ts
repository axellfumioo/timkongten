export async function logActivity(data: {
  user_name: string;
  user_email: string;
  activity_type: string;
  activity_name: string;
  activity_message?: string;
  activity_method?: string;
  activity_agent?: string;
  activity_url?: string;
}) {
  try {
    const res = await fetch(`${process.env.BASE_URL}/api/activity-log`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "x-api-key": process.env.INTERNAL_API_KEY!,
      },
      body: JSON.stringify(data),
    });

    const contentType = res.headers.get("content-type");
    let result = null;

    if (contentType && contentType.includes("application/json")) {
      result = await res.json();
    }

    if (!res.ok) {
      console.error("Log failed:", result ?? res.statusText);
    } else {
      console.log("Log success:", result);
    }
  } catch (error) {
    console.error("Activity log error:", error);
  }
}
