<script setup>
import { onMounted } from "vue";
import { useConnectionStore } from "@/stores/connection";
import { useItemStore } from "@/stores/item";

const connection = useConnectionStore();
const items = useItemStore();

onMounted(() => {
  connection.bindEvents();
  items.bindEvents();
  connection.connect(); // inicia conexão com socket
});
</script>

<template>
  <div>
    <h2>Status: {{ connection.isConnected ? '🟢 Conectado' : '🔴 Desconectado' }}</h2>
    <ul>
      <li v-for="item in items.items" :key="item.id">{{ item.label }}</li>
    </ul>
  </div>
</template>
