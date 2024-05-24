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
            <p class="info-label"><strong>관리자: </strong></p>
            <p class="info-value">{{ group.groupOwner }}</p>
          </div>
          <div class="info-item">
            <p class="info-label"><strong>지역: </strong></p>
            <p class="info-value">{{ group.region }}</p>
          </div>
          <div class="info-item">
            <p class="info-label"><strong>모임 방식: </strong></p>
            <p class="info-value">{{ group.isOnline ? "온라인" : "오프라인" }}</p>
          </div>
        </div>
        <div class="users-list">
          <h3>그룹 멤버</h3>
          <v-list>
            <v-list-item v-for="(user, index) in groupMembers" :key="index">
              <v-list-item-content>
                <v-list-item-title>{{ user.userId }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </div>
      </div>
      <v-btn
        @click="closeModal"
        class="centered-button"
        style="width: 90px; background-color: #58d8ff; color: aliceblue"
        >닫기</v-btn
      >
    </v-card>
  </v-container>
  <v-container v-else class="loading-container">
    <p>Loading...</p>
  </v-container>
</template>

<script>
import axios from "axios";

export default {
  name: "MyGroupDetail",
  props: {
    groupId: {
      type: [String, Number],
      required: true,
    },
    group: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      groupMembers: [],
      loading: false,
    };
  },
  created() {
    console.log("Group data in MyGroupDetail:", this.group); // Debugging log
    if (this.groupId) {
      this.fetchGroupMembers();
    } else {
      console.error("groupId is not defined");
    }
  },
  methods: {
    async fetchGroupMembers() {
      this.loading = true;
      try {
        const response = await axios.get(`http://localhost:8080/group/${this.groupId}/members`);
        console.log("Fetched group members:", response.data); // Debugging log
        this.groupMembers = response.data;
      } catch (error) {
        console.error("Error fetching group members:", error);
      } finally {
        this.loading = false;
      }
    },
    closeModal() {
      this.$emit("close");
    },
  },
};
</script>

<style scoped>
.group-module {
  transition: transform 0.3s ease;
  width: 500px; /* Keep width the same */
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  overflow: hidden;
  padding: 10px; /* Added padding to make space between the content and the border */
}

.group-module:hover {
  transform: scale(1.05);
}

.card-content {
  overflow-y: auto; /* Enable vertical scroll */
  max-height: 600px; /* Set max height to control content overflow */
  text-align: left; /* Align content to the left */
  padding: 0; /* Removed padding to reduce space */
  scrollbar-width: none; /* For Firefox */
  -ms-overflow-style: none; /* Internet Explorer 10+ */
}

.card-content::-webkit-scrollbar {
  display: none; /* For Chrome, Safari, and Opera */
}

.title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px; /* Adjust margin to reduce space */
  text-align: center; /* Center the title */
}

.group-info {
  text-align: left;
  margin-bottom: 20px; /* Add spacing between group info and members list */
}

.info-item {
  display: flex;
  align-items: center;
  padding: 2px 0; /* Adjust spacing between items */
}

.info-label {
  flex: 0 0 120px; /* Fixed width for labels */
  text-align: left; /* Align labels to the left */
  padding-right: 10px;
}

.info-value {
  flex: 1;
  width: 100px;
  white-space: nowrap; /* Prevent text wrapping */
  overflow: hidden; /* Hide overflow */
  text-overflow: ellipsis; /* Add ellipsis for overflowed text */
  text-align: left;
}

.users-list {
  text-align: left;
  margin-bottom: 10px; /* Adjust margin to add space between list and button */
}

.loading-container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  text-align: center;
}

.centered-button {
  margin-top: 10px; /* Adjust space between the text area and the button */
  margin-bottom: 10px; /* Adjust margin to reduce space between button and border */
}
</style>
