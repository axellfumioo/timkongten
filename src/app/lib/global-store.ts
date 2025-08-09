import { create } from 'zustand';

interface GlobalState {
  updated: boolean;
  setUpdated: (val: boolean) => void;
  cocOpen: boolean;
  setCocOpen: (val: boolean) => void;
}

export const useGlobalStore = create<GlobalState>((set) => ({
  updated: false,
  setUpdated: (val) => set({ updated: val }),
  cocOpen: false,
  setCocOpen: (val) => set({ cocOpen: val }),
}));
