<script setup>
import SockJS from 'sockjs-client';
import Stomp from 'webstomp-client';
import { useMemberStore } from '@/stores/member';
import { onMounted, ref } from 'vue';
import { storeToRefs } from 'pinia';
import { getMemberList } from '@/api/user';
import { useRouter } from 'vue-router';

const chatWindow = ref(false);
const senderId = ref("");
const receiverId = ref("");
const message = ref("");
const recvList = ref([]);
const memberList = ref([]);
const stompClient = ref(null);
const connected = ref(false);
const router = useRouter();
const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const toggleChatWindow = () => {
  if(!isLogin.value){
    alert("로그인을 해야합니다!")
    router.push("/member/login")
  }else{
    chatWindow.value = !chatWindow.value;
    senderId.value = userinfo.value.userId;
    getAllMember();
  }
};

const closeChatWindow = () => {
  chatWindow.value = false;
};

const getAllMember = () => {
  let userId = null;
  if (userinfo.value != null) {
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
  )
}

onMounted(() => {
  connect();
})
const connect = () => {
  const serverURL = "http://localhost:8080/ws";
  const socket = new SockJS(serverURL);
  stompClient.value = Stomp.over(socket);
  stompClient.value.connect(
    {},
    frame => {
      connected.value = true;
      console.log('소켓 연결 성공', frame);
      stompClient.value.subscribe("/topic/messages", res => {
        console.log('Received message:', res.body);
        recvList.value.push(JSON.parse(res.body));
      });
    },
    error => {
      connected.value = false;
      console.error('소켓 연결 실패', error);
    }
  );
}

const sendMessage = () => {
  if (senderId.value !== '' && message.value !== '' && receiverId.value !== '') {
    send();
    message.value = '';
  }
}

const send = () => {
  if (stompClient.value && stompClient.value.connected) {
    const msg = {
      senderId: senderId.value,
      receiverId: receiverId.value,
      content: message.value
    };
    stompClient.value.send("/app/receive", JSON.stringify(msg), {});
  }
}
</script>

<template>
  <div class="sticky-wrapper">
    <v-btn
      fab
      color="light-blue-accent-3"
      dark
      width="70px"
      height="70px"
      style="border-radius: 50px;"
      @click="toggleChatWindow"
    >
      <v-icon size="28px">mdi-message-text</v-icon>
    </v-btn>

    <v-dialog v-model="chatWindow" persistent max-width="600">
      <v-card>
        <v-card-title>Chat</v-card-title>
        <v-card-text>
          <v-autocomplete
            v-model="receiverId"
            label="받는 사람 아이디"
            :items="memberList"
            item-title="userId"
            item-value="userId"
            clearable
          ></v-autocomplete>
          <div class="chat-content">
            <div
              v-for="(item, idx) in recvList"
              :key="idx"
              class="message"
            >
              <p>유저이름: {{ item.senderId }}</p>
              <p>내용: {{ item.content }}</p>
            </div>
          </div>
          <v-textarea
            v-model="message"
            label="Type your message..."
            auto-grow
            rows="3"
            style="max-height: 150px; overflow-y: auto;"
          ></v-textarea>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="primary" @click="sendMessage">Send</v-btn>
          <v-btn color="secondary" @click="closeChatWindow">Close</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<style scoped>
.sticky-wrapper {
  position: fixed;
  bottom: 50px;
  right: 50px;
  z-index: 9999;
}
.chat-content {
  max-height: 300px;
  overflow-y: auto;
  margin-top: 16px;
}
.message {
  padding: 8px;
  background-color: #f3f3f3;
  border-radius: 8px;
  margin-bottom: 8px;
}
</style>
