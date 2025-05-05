<template>
  <v-container>
    <v-card class="pa-4" height="500px">
      <div class="overflow-y-auto mb-4" style="max-height: 350px;">
        <div
          v-for="msg in chat.messages"
          :key="msg.id"
          class="mb-2 pa-2 rounded bg-grey-lighten-3"
        >
          {{ msg.content }}
        </div>
      </div>

      <!-- Campo de entrada de mensagem -->
      <v-text-field
        v-model="message"
        label="Digite sua mensagem"
        @keyup.enter="send"
        :disabled="!connection.isConnected" 
        clearable
      />
      
      <v-btn @click="send" color="primary" :disabled="!connection.isConnected">Enviar</v-btn>
    </v-card>
  </v-container>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useChatStore } from "@/stores/chatStore";
import { useConnectionStore } from "@/stores/connectionStore";
import { socket } from "@/socket";

const chat = useChatStore();
const connection = useConnectionStore();
const message = ref("");

onMounted(() => {
  connection.bindEvents();
  chat.bindEvents();
  connection.connect();
});

function send() {
  if (message.value.trim()) {
    const newMessage = message.value.trim();

    // Enviar a mensagem para o servidor e só adicionar à lista depois da confirmação
    socket.emit("chat message", newMessage, null, (response) => {
      if (response.success) {
        chat.messages.push({ id: Date.now(), content: newMessage });
      } else {
        console.error("Erro ao enviar mensagem.");
      }
    });

    message.value = ""; // Limpa o campo após envio
  }
}
</script>
