import { defineStore } from 'pinia';

export const useUnReadMsgStore = defineStore('unReadMsg', {
  state: () => ({
    unReadMsgCount: 0,
  }),
  actions: {
    setUnReadMsgCount(count) {
      this.unReadMsgCount = count;
    },
    decrementUnReadMsgCount() {
      if (this.unReadMsgCount > 0) {
        this.unReadMsgCount--;
      }
    },
  },
});
