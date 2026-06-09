import { useState, useEffect } from "react";
import ContentModal from "../../contentModal";

interface Evidence {
    id: string;
    user_email: string;
    content_id: string | null;
    evidence_title: string;
    evidence_description: string;
    evidence_date: string;
    evidence_status: string;
    completion_proof: string;
    created_at: string;
    evidence_job: string;
}

interface Props {
    proofOpen: boolean;
    setProofOpen: (open: boolean) => void;
    selectedId: string | null;
}

export default function EvidenceModal({ proofOpen, setProofOpen, selectedId }: Props) {
    const [selectedContent, setSelectedContent] = useState<Evidence | null>(null);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        if (proofOpen && selectedId) {
            setLoading(true);
            setError(null);

            fetch(`/api/evidences/${selectedId}`)
                .then((res) => {
                    if (!res.ok) throw new Error(`Failed to fetch evidence: ${res.statusText}`);
                    return res.json();
                })
                .then((data: Evidence) => {
                    setSelectedContent(data);
                })
                .catch((err) => {
                    console.error("Fetch error:", err);
                    setError("Failed to load evidence.");
                    setSelectedContent(null);
                })
                .finally(() => setLoading(false));
        } else {
            // Reset state when modal closes or no selectedId
            setSelectedContent(null);
            setLoading(false);
            setError(null);
        }
    }, [proofOpen, selectedId]);

    return (
        <ContentModal
            isOpen={proofOpen}
            onClose={() => {
                setSelectedContent(null);
                setProofOpen(false);
                setLoading(false);
                setError(null);
            }}
        >
            {loading ? (
                <p className="text-center text-gray-500">Loading evidence...</p>
            ) : error ? (
                <p className="text-center text-red-500">{error}</p>
            ) : selectedContent ? (
                <>
                    <h2 className="text-2xl font-semibold mb-6">
                        Completion Proof {selectedContent.evidence_title}
                    </h2>
                    {selectedContent.completion_proof ? (
                        <div className="flex justify-center mt-4">
                            <a
                                href={selectedContent.completion_proof.startsWith('http') ? selectedContent.completion_proof : `https://${selectedContent.completion_proof}`}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="bg-gray-900 hover:bg-gray-800 text-white font-bold py-3 px-6 rounded-lg shadow-lg transition-all"
                            >
                                Buka Link Bukti 🔗
                            </a>
                        </div>
                    ) : (
                        <p className="text-center text-gray-400">Tidak ada link bukti</p>
                    )}
                </>
            ) : (
                <p className="text-center text-gray-400">No evidence selected</p>
            )}
        </ContentModal>
    );
}
