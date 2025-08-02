'use client'
import React, { useState } from 'react'

type CalendarDay = {
    day: number
    currentMonth: boolean
    month: number
    year: number
}

const weekdays = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab']

const Calendar = () => {
    const today = new Date()
    const [currentDate, setCurrentDate] = useState(new Date())
    const [selectedDate, setSelectedDate] = useState<CalendarDay | null>(null)

    const dummyEvents: Record<string, string> = {
        '2025-04-26': 'Ulangan Kimia',
        '2025-04-28': 'Tugas Sejarah',
        '2025-05-02': 'Presentasi Inggris',
    }

    const getDaysInMonth = (year: number, month: number) =>
        new Date(year, month + 1, 0).getDate()

    const getCalendarDays = (): CalendarDay[] => {
        const year = currentDate.getFullYear()
        const month = currentDate.getMonth()

        const daysInMonth = getDaysInMonth(year, month)
        const startDay = new Date(year, month, 1).getDay()

        const prevMonth = month === 0 ? 11 : month - 1
        const nextMonth = month === 11 ? 0 : month + 1
        const prevYear = month === 0 ? year - 1 : year
        const nextYear = month === 11 ? year + 1 : year

        const daysInPrevMonth = getDaysInMonth(prevYear, prevMonth)

        const days: CalendarDay[] = []

        // Days from previous month
        for (let i = startDay - 1; i >= 0; i--) {
            days.push({
                day: daysInPrevMonth - i,
                currentMonth: false,
                month: prevMonth,
                year: prevYear,
            })
        }

        // Current month
        for (let i = 1; i <= daysInMonth; i++) {
            days.push({
                day: i,
                currentMonth: true,
                month,
                year,
            })
        }

        // Fill next month
        const remaining = 42 - days.length
        for (let i = 1; i <= remaining; i++) {
            days.push({
                day: i,
                currentMonth: false,
                month: nextMonth,
                year: nextYear,
            })
        }

        return days
    }

    const calendarDays = getCalendarDays()

    const handleMonthChange = (offset: number) => {
        const newDate = new Date(currentDate)
        newDate.setMonth(newDate.getMonth() + offset)
        setCurrentDate(newDate)
    }

    const monthLabel = currentDate.toLocaleString('id-ID', {
        month: 'long',
        year: 'numeric',
    })

    return (
        <div className="bg-[#121212] w-full p-5 rounded-2xl shadow-lg border border-white/5">
            <div className="flex items-center justify-between mb-4">
                <h2 className="text-lg font-bold flex items-center gap-2">🗓️ {monthLabel}</h2>
                <div className="flex gap-2">
                    <button
                        onClick={() => handleMonthChange(-1)}
                        className="text-white/50 hover:text-white transition"
                    >
                        ←
                    </button>
                    <button
                        onClick={() => handleMonthChange(1)}
                        className="text-white/50 hover:text-white transition"
                    >
                        →
                    </button>
                </div>
            </div>

            {/* Days of week */}
            <div className="grid grid-cols-7 text-center text-white/50 text-xs font-semibold mb-2">
                {weekdays.map((day, i) => (
                    <div key={i}>{day}</div>
                ))}
            </div>

            {/* Calendar grid */}
            <div className="grid grid-cols-7 gap-1">
                {calendarDays.map(({ day, currentMonth, month, year }, i) => {
                    const isToday =
                        day === today.getDate() &&
                        month === today.getMonth() &&
                        year === today.getFullYear()

                    const isSelected =
                        selectedDate &&
                        selectedDate.day === day &&
                        selectedDate.month === month &&
                        selectedDate.year === year

                    const dateKey = `${year}-${String(month + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`
                    const hasEvent = !!dummyEvents[dateKey]

                    return (
                        <div
                            key={i}
                            onClick={() => setSelectedDate({ day, month, year, currentMonth })}
                            className={`
                relative aspect-square flex items-center justify-center text-xs rounded-xl cursor-pointer
                transition-all
                ${currentMonth ? 'text-white hover:bg-white/10' : 'text-white/30'}
                ${isToday ? 'border border-white font-bold' : ''}
                ${isSelected ? 'bg-white/20' : ''}
              `}
                            title={hasEvent ? dummyEvents[dateKey] : ''}
                        >
                            {day}
                            {hasEvent && (
                                <span className="absolute bottom-[4px] w-[6px] h-[6px] bg-green-400 rounded-full" />
                            )}
                        </div>
                    )
                })}
            </div>
        </div>
    )
}

export default Calendar
