<template>
  <v-container fluid class="no-padding no-margin">
    <v-row no-gutters class="no-padding no-margin">
      <v-col class="no-padding no-margin">
        <Map v-if="place && place.x && place.y" :x="place.x" :y="place.y" />
      </v-col>
    </v-row>
    <v-row no-gutters class="no-padding no-margin">
      <v-col class="no-padding no-margin">
        <PlaceDetail v-if="place" :place="place" />
      </v-col>
    </v-row>
    <v-row no-gutters class="no-padding" style="margin-top: 20px">
      <v-col class="no-padding no-margin">
        <ReviewPreview
          v-if="place"
          :place="place"
          :reviews="reviews"
          :total-reviews="totalReviews"
        />
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Map from "./Map.vue";
import PlaceDetail from "./PlaceDetail.vue";
import ReviewPreview from "./ReviewPreview.vue";
import axios from "axios";

export default {
  components: {
    Map,
    PlaceDetail,
    ReviewPreview,
  },
  data() {
    return {
      place: null,
      reviews: [],
      totalReviews: 0,
    };
  },
  created() {
    const id = this.$route.params.id;
    console.log(`Fetching details for place ID: ${id}`);
    axios
      .get(`http://localhost:8080/place/${id}`)
      .then((response) => {
        const place = response.data;
        console.log("Fetched place:", place);
        if (place.x && place.y) {
          place.x = parseFloat(place.x);
          place.y = parseFloat(place.y);
        }
        this.place = place;
        this.fetchReviews(id);
        this.fetchTotalReviews(id);
      })
      .catch((error) => {
        console.error("Error fetching place details:", error);
      });
  },
  methods: {
    fetchReviews(placeId) {
      axios
        .get(`http://localhost:8080/reviews/place/${placeId}/top-liked`)
        .then((response) => {
          this.reviews = response.data;
        })
        .catch((error) => {
          console.error("Error fetching reviews:", error);
        });
    },
    fetchTotalReviews(placeId) {
      axios
        .get(`http://localhost:8080/reviews/place/${placeId}`)
        .then((response) => {
          this.totalReviews = response.data.length;
        })
        .catch((error) => {
          console.error("Error fetching total reviews:", error);
        });
    },
  },
};
</script>

<style scoped>
.no-padding {
  padding: 0 !important;
}

.no-margin {
  margin: -10 !important;
}

v-container,
v-row,
v-col {
  padding: 0;
  margin: 0;
  width: 100%;
}
.test {
  width: 10000px;
}
</style>
