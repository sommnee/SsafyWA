<template>
  <div id="app" style="margin-top: 10%">
    <h2>쪽지 보내기</h2>
    <br />
    <v-container>
      <v-row class="">
        <v-col cols="12">
          <v-row class="align-center">
            <v-col cols="12">
              <v-autocomplete
                v-model="receiverId"
                label="받는 사람 아이디"
                :items="memberList"
                item-title="userId"
                item-value="userId"
                clearable
              ></v-autocomplete>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <v-row class="mb-2">
        <v-col cols="12">
          <v-row class="align-center">
            <v-col cols="12">
              <v-textarea
                v-model="message"
                label="내용"
                clearable
                auto-grow
                rows="5"
                outlined
              ></v-textarea>
            </v-col>
          </v-row>
        </v-col>
      </v-row>

      <v-row class="mb-4">
        <v-col cols="12" class="text-right">
          <v-btn
            @click="sendMessage"
            style="width: 70px; background-color: #58d8ff; color: aliceblue; margin-right: 20px"
            >전송</v-btn
          >
          <v-btn
            @click="closeModal"
            class="centered-button"
            style="width: 70px; background-color: #f3f5f6; color: darkgray"
            >닫기</v-btn
          >
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script setup>
import SockJS from "sockjs-client";
import Stomp from "webstomp-client";
import { useMemberStore } from "@/stores/member";
import { onMounted, ref } from "vue";
import { storeToRefs } from "pinia";
import { getMemberList } from "@/api/user";

const emit = defineEmits(["close"]);
const senderId = ref("");
const receiverId = ref("");
const message = ref("");
const recvList = ref([]);
const memberList = ref([]);
const stompClient = ref(null);
const connected = ref(false);
const memberStore = useMemberStore();
const { userinfo } = storeToRefs(memberStore);

const getAllMember = () => {
  let userId = null;
  if (userinfo != null) {
    userId = userinfo.value.userId;
  }
  getMemberList(
    userId,
    ({ data }) => {
      console.log(data);
      memberList.value = data;
    },
    (error) => {
      console.log(error);
    }
  );
};

onMounted(() => {
  getAllMember();
  connect();
  senderId.value = userinfo.value.userId;
});

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
        recvList.value.push(JSON.parse(res.body));
      });
    },
    (error) => {
      connected.value = false;
      console.error("소켓 연결 실패", error);
    }
  );
};

const sendMessage = () => {
  if (senderId.value !== "" && message.value !== "" && receiverId.value !== "") {
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

const closeModal = () => {
  emit("close");
};
</script>

<style scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  margin-top: 60px;
}

.message-item {
  background-color: #f5f5f5;
  margin-bottom: 10px;
  border-radius: 5px;
  padding: 10px;
}
</style>
