<template>
  <v-container>
    <v-row style="border-radius: 5px">
      <v-col cols="12">
        <v-list>
          <v-list-item v-for="group in groups" :key="group.id" class="groupItem">
            <v-list-item-content>
              <v-row>
                <v-col cols="8">
                  <v-list-item-title>{{ group.groupName }}</v-list-item-title>
                  <v-list-item-subtitle v-if="group.isOwner">관리자</v-list-item-subtitle>
                  <v-list-item-subtitle v-if="!group.isOwner">멤버</v-list-item-subtitle>
                </v-col>
                <v-col cols="4" class="text-right d-flex align-center justify-center">
                  <v-btn
                    v-if="group.isOwner"
                    @click="editGroup(group)"
                    small
                    class="mx-2"
                    style="background-color: #58d8ff; color: aliceblue"
                  >
                    수정
                  </v-btn>
                  <v-btn
                    v-if="group.isOwner"
                    @click="addUser(group)"
                    small
                    class="mx-2"
                    style="background-color: #58d8ff; color: aliceblue"
                  >
                    멤버 추가
                  </v-btn>
                  <v-btn
                    v-if="!group.isOwner"
                    @click="viewGroup(group)"
                    small
                    class="mx-2"
                    style="background-color: #58d8ff; color: aliceblue"
                  >
                    보기
                  </v-btn>
                </v-col>
              </v-row>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-col>
    </v-row>

    <v-dialog v-model="showEditGroup" max-height="650px" max-width="500px">
      <v-card style="border-radius: 20px">
        <v-card-text>
          <EditGroup :group="selectedGroup" @close="showEditGroup = false" />
        </v-card-text>
      </v-card>
    </v-dialog>

    <v-dialog v-model="showAddUser" max-width="500px">
      <v-card style="border-radius: 20px">
        <v-card-text>
          <AddUser :group="selectedGroup" :groupId="selectedGroup.id" @close="closeAddUser" />
        </v-card-text>
      </v-card>
    </v-dialog>

    <v-dialog v-model="showGroupDetail" max-width="500px" max-height="1500px">
      <v-card style="border-radius: 20px">
        <v-card-text>
          <MyGroupDetail
            :group="selectedGroup"
            :groupId="selectedGroup.id"
            @close="showGroupDetail = false"
          />
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRouter } from "vue-router";
import { storeToRefs } from "pinia";
import { useMemberStore } from "@/stores/member";
import EditGroup from "@/components/group/EditGroup.vue";
import AddUser from "@/components/group/AddUser.vue";
import MyGroupDetail from "@/components/group/MyGroupDetail.vue";

const router = useRouter();
const memberStore = useMemberStore();
const { userinfo, isLogin } = storeToRefs(memberStore);

const groups = ref([]);
const selectedGroup = ref({
  id: null,
  groupName: "",
  users: [],
});
const showEditGroup = ref(false);
const showAddUser = ref(false);
const showGroupDetail = ref(false);

const fetchUserGroups = async () => {
  if (!isLogin.value) {
    alert("로그인 후 이용하세요");
    router.push("/login");
    return;
  }

  try {
    const response = await axios.get(`http://localhost:8080/group/user/${userinfo.value.userId}`);
    const userGroups = response.data;

    groups.value = userGroups.map((group) => ({
      ...group,
      isOwner: group.groupOwner === userinfo.value.userId,
    }));
  } catch (error) {
    console.error("Failed to fetch user groups:", error);
  }
};

onMounted(() => {
  if (isLogin.value) {
    fetchUserGroups();
  }
});

const editGroup = (group) => {
  selectedGroup.value = group;
  showEditGroup.value = true;
};

const addUser = (group) => {
  selectedGroup.value = group;
  showAddUser.value = true;
};

const closeAddUser = () => {
  showAddUser.value = false;
  fetchUserGroups(); // Refresh the group list after adding a user
};

const viewGroup = (group) => {
  selectedGroup.value = group;
  showGroupDetail.value = true;
};
</script>

<style scoped>
h3 {
  margin-bottom: 20px;
}

.v-list-item {
  cursor: pointer;
  border-radius: 5px;
}

.v-list-item:hover {
  background-color: #f5f5f5;
}

.text-right {
  text-align: right;
}

.groupItem {
  margin-bottom: 30px;
  height: 100px;
  border: 1px solid #58d8ff; /* Add border */
  padding: 10px; /* Add padding for better spacing */
  border-radius: 10px !important; /* Add border radius with !important */
}
</style>
