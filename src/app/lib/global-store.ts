import { create } from 'zustand';

interface GlobalState {
  updated: boolean;
  setUpdated: (val: boolean) => void;
  cocOpen: boolean;
  setCocOpen: (val: boolean) => void;
}

// Keep a debounced timer to delay the "updated" trigger
let updatedTimer: ReturnType<typeof setTimeout> | null = null;

export const useGlobalStore = create<GlobalState>((set) => ({
  updated: false,
  // When setting `updated` to true, wait 1500ms before applying it.
  // Setting it to false clears any pending trigger and applies immediately.
  setUpdated: (val) => {
    if (updatedTimer) {
      clearTimeout(updatedTimer);
      updatedTimer = null;
    }

    if (val) {
      updatedTimer = setTimeout(() => {
        set({ updated: true });
        updatedTimer = null;
      }, 800);
    } else {
      set({ updated: false });
    }
  },
  cocOpen: false,
  setCocOpen: (val) => set({ cocOpen: val }),
}));
