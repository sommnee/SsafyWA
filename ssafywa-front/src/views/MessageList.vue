<script setup>
import { ref, onMounted, watch, computed } from "vue";
import { getUserReceivedMsg, getUnReadMsg, getUserSendMsg, makeUnreadToRead } from "@/api/socket.js";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";
import { useUnReadMsgStore } from "@/stores/message";
const tab = ref(1);
const receivedMsgList = ref([]);
const unReadMsgList = ref([]);
const sentMsgList = ref([]);
const memberStore = useMemberStore();
const { userinfo } = storeToRefs(memberStore);
const unReadMsgStore = useUnReadMsgStore();

// Pagination states
const receivedPage = ref(1);
const unReadPage = ref(1);
const sentPage = ref(1);
const itemsPerPage = 5;

// Fetch messages function
const fetchMessages = async () => {
  const userId = userinfo.value.userId;
  if (tab.value === 1) {
    await getUserReceivedMsg(
      userId,
      ({ data }) => {
        console.log("Received Messages: ", data);
        receivedMsgList.value = data;
      },
      (error) => {
        console.error(error);
      }
    );
  } else if (tab.value === 2) {
    await getUnReadMsg(
      userId,
      ({ data }) => {
        console.log("Unread Messages: ", data);
        unReadMsgList.value = data;
      },
      (error) => {
        console.error(error);
      }
    );
  } else if (tab.value === 3) {
    await getUserSendMsg(
      userId,
      ({ data }) => {
        console.log("Sent Messages: ", data);
        sentMsgList.value = data;
      },
      (error) => {
        console.error(error);
      }
    );
  }
};

watch(tab, fetchMessages, { immediate: true });

onMounted(fetchMessages);

// Define computed properties for paginated data
const paginatedReceivedMsgList = computed(() => {
  const start = (receivedPage.value - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  return receivedMsgList.value.slice(start, end);
});

const paginatedUnReadMsgList = computed(() => {
  const start = (unReadPage.value - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  return unReadMsgList.value.slice(start, end);
});

const paginatedSentMsgList = computed(() => {
  const start = (sentPage.value - 1) * itemsPerPage;
  const end = start + itemsPerPage;
  return sentMsgList.value.slice(start, end);
});
const dialog = ref(false);
const selectedMessage = ref(null);
const goToDetail = (msg) => {
  // router.push(`/msg/detail/${id}`);
  makeUnreadToRead(
        msg.id,
        ({data}) => {
            console.log("읽기 성공, 읽기 처리 완료", data)
            unReadMsgStore.decrementUnReadMsgCount();
        },
        (error) => {
            console.error(error)
        }
    )
    fetchMessages();
  selectedMessage.value = msg;
  dialog.value = true;
}

</script>

<template>
  <v-card style="margin-top: 5%; padding: 30px;">
    <v-tabs v-model="tab" align-tabs="left" color="deep-blue-accent-4">
      <v-tab :value="1">내 쪽지</v-tab>
      <v-tab :value="2">읽지 않은 쪽지</v-tab>
      <v-tab :value="3">내가 쓴 쪽지</v-tab>
    </v-tabs>

    <v-tabs-window v-model="tab">
      <v-tabs-window-item :value="1">
        <v-container fluid>
          <v-row>
            <v-col v-for="(msg, i) in paginatedReceivedMsgList" :key="i" cols="12">
              <v-card class="mb-2" style="background-color: #F3F5F6;" 
                @click="goToDetail(msg)">
                <v-card-title>{{ msg.content }}</v-card-title>
                <v-card-text class="details"><span class="author">{{ msg.senderId }}</span> | <span class="date">{{ msg.timestamp }}</span></v-card-text>
              </v-card>
            </v-col>
          </v-row>
          <v-pagination
            v-model="receivedPage"
            :length="Math.ceil(receivedMsgList.length / itemsPerPage)"
            :total-visible="7"
            class="mt-4"
            style="margin-bottom: 0px;"
          ></v-pagination>
        </v-container>
      </v-tabs-window-item>

      <v-tabs-window-item :value="2">
        <v-container fluid>
          <v-row>
            <v-col v-for="(msg, i) in paginatedUnReadMsgList" :key="i" cols="12">
              <v-card class="mb-2" @click="goToDetail(msg)" style="background-color: #F3F5F6;">
                <v-card-title>{{ msg.content }}</v-card-title>
                <v-card-text class="details"><span class="author">{{ msg.senderId }}</span> | <span class="date">{{ msg.timestamp }}</span></v-card-text>
              </v-card>
            </v-col>
          </v-row>
          <v-pagination
            v-model="unReadPage"
            :length="Math.ceil(unReadMsgList.length / itemsPerPage)"
            :total-visible="7"
            class="mt-4"
            style="margin-bottom: 0px;"
          ></v-pagination>
        </v-container>
      </v-tabs-window-item>

      <v-tabs-window-item :value="3">
        <v-container fluid>
          <v-row>
            <v-col v-for="(msg, i) in paginatedSentMsgList" :key="i" cols="12">
              <v-card class="mb-2" @click="goToDetail(msg)" style="background-color: #F3F5F6;">
                <v-card-title>{{ msg.content }}</v-card-title>
                <v-card-text class="details"><span class="author">{{ msg.senderId }}</span> | <span class="date">{{ msg.timestamp }}</span></v-card-text>
              </v-card>
            </v-col>
          </v-row>
          <v-pagination
            v-model="sentPage"
            :length="Math.ceil(sentMsgList.length / itemsPerPage)"
            :total-visible="7"
            class="mt-4"
            style="margin-bottom: 0px;"
          ></v-pagination>
        </v-container>
      </v-tabs-window-item>
    </v-tabs-window>
  </v-card>
  <v-dialog v-model="dialog" persistent max-width="600px" 
    style="border-radius: 5px; padding: 30px;">
    <v-card>
      <v-card-text style="background-color: #F3F5F6;"> 
        작성자: {{ selectedMessage?.senderId }} | 
        <span class="date">보낸 날짜: {{ selectedMessage.timestamp }}</span>
      </v-card-text>
      <hr/>
      <v-card-title style="margin-top: 10px; margin-left: 5px;">
        <p>{{ selectedMessage?.content }}</p>
      </v-card-title>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="dialog = false">닫기</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<style scoped>
.v-card {
  display: flex;
  flex-direction: column;
  /* background-color: #F3F5F6; */
  /* min-height: 70vh; Adjust as needed */
}
.v-card:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* hover 시 그림자 효과 */
  transform: translateY(-5px); /* hover 시 살짝 위로 이동 */
  cursor: pointer; /* hover 시 커서 변경 */
  }
.v-tabs-items {
  flex-grow: 1;
}
.details{
  color: #14B5E6
}
</style>
