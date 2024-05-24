<script setup>
import { ref, onMounted, watch, defineProps } from "vue";

const props = defineProps({
  x: {
    type: Number,
    required: true,
  },
  y: {
    type: Number,
    required: true,
  },
});

const mapContainer = ref(null);
let map;
let marker;

onMounted(() => {
  const options = {
    center: new kakao.maps.LatLng(props.y, props.x), // Use props to set the center
    level: 2,
  };

  map = new kakao.maps.Map(mapContainer.value, options);

  // Add marker at the specified coordinates
  const markerPosition = new kakao.maps.LatLng(props.y, props.x);
  marker = new kakao.maps.Marker({
    position: markerPosition,
  });
  marker.setMap(map);
});

// Watch for changes in props to update the map center and marker position
watch(
  () => [props.x, props.y],
  ([newX, newY]) => {
    if (map) {
      const moveLatLon = new kakao.maps.LatLng(newY, newX);
      map.setCenter(moveLatLon);

      // Update marker position
      marker.setPosition(moveLatLon);
    }
  }
);
</script>

<template>
  <div ref="mapContainer" class="map-container"></div>
</template>

<style scoped>
.map-container {
  width: 100%;
  height: 450px;
  margin: 0; /* Ensure no margin */
  padding: 0; /* Ensure no padding */
}
</style>
