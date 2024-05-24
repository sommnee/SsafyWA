<template>
  <v-container class="d-flex justify-center align-center vcon" v-if="group">
    <v-card
      class="group-module"
      outlined
      rounded="lg"
      :style="{ borderColor: '#58d8ff', borderWidth: '2px', borderRadius: '10px' }"
    >
      <div class="card-content">
        <v-card-title class="text-center title">{{ group.groupName }}</v-card-title>
        <div class="group-info">
          <div class="info-item">
            <p class="info-label"><strong>종류: </strong></p>
            <p class="info-value">{{ group.type }}</p>
          </div>
          <div class="info-item">
            <p class="info-label"><strong>지역: </strong></p>
            <p class="info-value">{{ group.region }}</p>
          </div>
          <div class="info-item">
            <p class="info-label"><strong>모임 방식: </strong></p>
            <p class="info-value">{{ group.isOnline ? "온라인" : "오프라인" }}</p>
          </div>
          <div class="info-item">
            <p class="info-label"><strong>모집 인원: </strong></p>
            <p class="info-value">{{ group.recruitMaxNumber }}</p>
          </div>
        </div>
        <div class="group-content">
          <h3>설명</h3>
          <br />
          <p>{{ group.content }}</p>
        </div>
        <div class="button-container">
          <v-btn
            @click="applyForGroup"
            class="centered-button"
            style="width: 90px; background-color: #58d8ff; color: aliceblue"
            >신청</v-btn
          >
          <v-btn
            @click="closeModal"
            class="centered-button"
            style="width: 90px; background-color: #f3f5f6; color: darkgrey; margin-left: 10px"
            >닫기</v-btn
          >
        </div>
        <v-alert v-if="alert" type="success" dismissible v-model="alert" class="mt-3">
          신청 완료되었습니다!
        </v-alert>
      </div>
    </v-card>
  </v-container>
</template>

<script setup>
import { defineProps, defineEmits, watch, ref } from "vue";
import { useUnReadMsgStore } from "@/stores/message";
import axios from "axios";
import SockJS from "sockjs-client";
import Stomp from "webstomp-client";
import { useMemberStore } from "@/stores/member";
import { storeToRefs } from "pinia";

// Define props
const props = defineProps({
  group: {
    type: Object,
    required: true,
  },
});

// Define emits
const emit = defineEmits(["close"]);

const group = ref(props.group);
const memberStore = useMemberStore();
const unReadMsgStore = useUnReadMsgStore();
const { userinfo } = storeToRefs(memberStore);
const stompClient = ref(null);
const connected = ref(false);
const senderId = ref("");
const receiverId = ref("");
const message = ref("");
const alert = ref(false);

const applyForGroup = () => {
  senderId.value = userinfo.value.userId;
  receiverId.value = group.value.groupOwner;
  message.value = `${senderId.value}님이 ${group.value.groupName}에 가입신청을 했습니다.`;
  sendMessage();
  alert.value = true;
  setTimeout(() => (alert.value = false), 3000); // Hide alert after 3 seconds
};

watch(
  () => props.group,
  (newGroup) => {
    group.value = newGroup;
  },
  { immediate: true }
);

const sendMessage = () => {
  if (senderId.value !== "" && receiverId.value !== "") {
    send();
    message.value = "";
    receiverId.value = "";
  }
};

const send = () => {
  if (stompClient.value && stompClient.value.connected) {
    const msg = {
      senderId: senderId.value,
      receiverId: receiverId.value,
      content: message.value,
    };
    stompClient.value.send("/app/notify", JSON.stringify(msg), {});
  }
};

const connect = () => {
  const serverURL = "http://localhost:8080/ws";
  const socket = new SockJS(serverURL);
  stompClient.value = Stomp.over(socket);
  stompClient.value.connect(
    {},
    (frame) => {
      connected.value = true;
      console.log("소켓 연결 성공", frame);
      stompClient.value.subscribe("/topic/notify", (res) => {
        console.log("Received message:", res.body);
        const data = JSON.parse(res.body);
        if (data.msgInfo.receiverId === userinfo.value.userId) {
          unReadMsgStore.setUnReadMsgCount(data.unReadMsgCount);
        }
      });
    },
    (error) => {
      connected.value = false;
      console.error("소켓 연결 실패", error);
    }
  );
};

const closeModal = () => {
  emit("close");
};

connect();
</script>

<style scoped>
.group-module {
  transition: transform 0.3s ease;
  width: 500px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  padding: 10px;
}

.group-module:hover {
  transform: scale(1.05);
}

.card-content {
  overflow-y: auto;
  max-height: 600px;
  text-align: left;
  padding: 0;
  scrollbar-width: none;
}

.card-content::-webkit-scrollbar {
  display: none;
}

.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
  text-align: center;
}

.group-info {
  text-align: left;
  margin-bottom: 20px;
}

.info-item {
  display: flex;
  align-items: center;
  padding: 2px 0;
}

.info-label {
  flex: 0 0 120px;
  text-align: left;
  padding-right: 10px;
}

.info-value {
  flex: 1;
  width: 100px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  text-align: left;
}

.group-content {
  text-align: left;
  margin-bottom: 20px;
}

.loading-container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  text-align: center;
}

.button-container {
  display: flex;
  justify-content: center;
  width: 100%;
}

.centered-button {
  margin-top: 10px;
  margin-bottom: 10px;
}
</style>
