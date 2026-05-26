import { create } from 'zustand';

interface GlobalState {
  updateTrigger: number;
  triggerUpdate: () => void;
  cocOpen: boolean;
  setCocOpen: (val: boolean) => void;
}

export const useGlobalStore = create<GlobalState>((set) => ({
  updateTrigger: 0,
  triggerUpdate: () => set((state) => ({ updateTrigger: state.updateTrigger + 1 })),
  cocOpen: false,
  setCocOpen: (val) => set({ cocOpen: val }),
}));
