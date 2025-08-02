'use client'
import { useState } from 'react'
import { CheckCircle, Clock, Flag } from 'lucide-react'

type Priority = 'High' | 'Medium' | 'Low'

interface Task {
    id: number
    title: string
    time: string
    priority: Priority
    done: boolean
}

const priorityColor = {
    High: 'text-red-500',
    Medium: 'text-yellow-400',
    Low: 'text-green-400',
}

export default function TodoList() {
    const [tasks, setTasks] = useState<Task[]>([
        { id: 1, title: 'Belajar Matematika', time: '07:30', priority: 'High', done: false },
        { id: 2, title: 'Baca Biologi', time: '10:00', priority: 'Medium', done: true },
        { id: 3, title: 'Kerjain Soal Fisika', time: '13:00', priority: 'High', done: false },
        { id: 4, title: 'Ngoding REST API', time: '15:30', priority: 'Low', done: false },
    ])

    const toggleDone = (id: number) => {
        setTasks(prev =>
            prev.map(task =>
                task.id === id ? { ...task, done: !task.done } : task
            )
        )
    }

    const sortedTasks = [...tasks].sort((a, b) => a.time.localeCompare(b.time))

    return (
        <div className="bg-[#121212] rounded-3xl p-6 shadow-lg border border-white/5 w-full">
            <h2 className="text-xl font-bold mb-4 flex items-center gap-2">📝 To-Do List Hari Ini</h2>
            <ul className="space-y-4 text-sm">
                {sortedTasks.map((task) => (
                    <li
                        key={task.id}
                        onClick={() => toggleDone(task.id)}
                        className={`flex justify-between items-center bg-[#1a1a1a] px-4 py-3 rounded-2xl hover:bg-white/10 cursor-pointer transition-all duration-150 ${task.done ? 'opacity-60' : ''
                            }`}
                    >
                        <div className="flex flex-col gap-1">
                            <span className={`text-white ${task.done ? 'line-through' : ''}`}>
                                {task.title}
                            </span>
                            <div className="flex items-center gap-2 text-white/50 text-xs">
                                <span className="flex items-center gap-1">
                                    <Clock size={14} /> {task.time}
                                </span>
                                <span className="flex items-center gap-1">
                                    <Flag size={14} className={priorityColor[task.priority]} />
                                    <span className={priorityColor[task.priority]}>{task.priority}</span>
                                </span>
                            </div>
                        </div>
                        {task.done && <CheckCircle className="text-green-400" size={20} />}
                    </li>
                ))}
            </ul>
        </div>
    )
}
