<template>
  <v-container class="bordered-container">
    <h2 class="group-name">{{ group.groupName }}</h2>
    <v-form>
      <v-autocomplete
        v-model="selectedUser"
        :items="allUsers"
        label="멤버 검색"
        solo-filled
        :loading="loading"
        :disabled="loading"
      ></v-autocomplete>
      <div class="button-container">
        <v-btn @click="addUser" :disabled="loading || !selectedUser" class="custom-button">
          추가
        </v-btn>
      </div>
    </v-form>
    <v-list class="members-list">
      <v-list-item v-for="(user, index) in groupMembers" :key="index" class="bordered-item">
        {{ user.userId }}
      </v-list-item>
    </v-list>
    <div class="close-button-container">
      <v-btn @click="closeModal" class="close-button">닫기</v-btn>
    </div>
    <v-alert v-if="alert" type="success" dismissible v-model="alert">
      멤버 추가 완료하였습니다!
    </v-alert>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  props: {
    groupId: {
      type: [String, Number],
      required: true,
    },
    group: {
      type: Object,
      required: true,
      default: () => ({
        id: null,
        groupName: "",
        users: [],
      }),
    },
  },
  data() {
    return {
      selectedUser: "",
      allUsers: [],
      groupMembers: [],
      loading: false,
      alert: false,
    };
  },
  created() {
    this.fetchAllUserIds();
    this.fetchGroupMembers();
  },
  methods: {
    async fetchAllUserIds() {
      this.loading = true;
      try {
        const response = await axios.get(`http://localhost:8080/member/all-ids`);
        console.log("Fetched user IDs:", response.data); // Debugging log
        this.allUsers = response.data;
      } catch (error) {
        console.error("Error fetching user IDs:", error);
      } finally {
        this.loading = false;
      }
    },
    async fetchGroupMembers() {
      try {
        const response = await axios.get(`http://localhost:8080/group/${this.groupId}/members`);
        console.log("Fetched group members:", response.data); // Debugging log
        this.groupMembers = response.data;
      } catch (error) {
        console.error("Error fetching group members:", error);
      }
    },
    async addUser() {
      if (this.selectedUser) {
        this.loading = true;
        try {
          console.log("Adding user:", this.selectedUser); // Debugging log
          const response = await axios.post(
            `http://localhost:8080/group/${this.groupId}/addMember`,
            { userId: this.selectedUser },
            {
              headers: {
                "Content-Type": "application/json",
              },
            }
          );
          console.log("Add user response:", response); // Debugging log
          // Add the user to the local list immediately
          this.groupMembers.push({ userId: this.selectedUser });
          this.selectedUser = "";
          this.alert = true; // Show success alert
          setTimeout(() => (this.alert = false), 3000); // Hide alert after 3 seconds
        } catch (error) {
          console.error("Error adding user to group:", error);
        } finally {
          this.loading = false;
        }
      }
    },
  },
};

const closeModal = () => {
  emit("close");
};
</script>

<style scoped>
.group-name {
  text-align: center;
  margin-bottom: 20px;
  font-size: 24px; /* Larger font size */
}

.v-form {
  margin-bottom: 20px; /* Add spacing between form and list */
}

.button-container {
  display: flex;
  justify-content: center;
  margin-top: 10px;
  margin-bottom: 20px; /* Add spacing below button */
}

.custom-button {
  background-color: #58d8ff;
  color: aliceblue;
}

.bordered-container {
  border: 2px solid #58d8ff;
  border-radius: 10px;
  padding: 40px 20px; /* Add padding to create more space at the top and bottom */
  max-width: 800px; /* Increased width */
  margin: 0 auto; /* Center the container */
}

.members-list {
  padding-top: 20px; /* Add spacing above the list */
}

.bordered-item {
  border-bottom: 1px solid #58d8ff;
  padding: 10px 0; /* Add padding to list items */
}

.bordered-item:last-child {
  border-bottom: none;
}

.close-button-container {
  display: flex;
  justify-content: center;
  margin-top: 20px; /* Add spacing above the close button */
}

.close-button {
  background-color: #f3f5f6;
  color: darkgray;
}
</style>
