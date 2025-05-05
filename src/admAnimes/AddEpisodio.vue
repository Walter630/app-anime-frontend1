// <template>
//     <v-card class="ma-4 pa-4" max-width="600" elevation="6">
//       <v-card-title>Adicionar Episódio</v-card-title>
  
//       <v-card-text>
//         <v-text-field v-model="form.title" label="Título" outlined dense />
//         <v-textarea v-model="form.description" label="Descrição" outlined dense />
//         <v-text-field v-model.number="form.episodio" label="Número do Episódio" type="number" outlined dense />
  
//         <v-btn color="primary" class="mt-4" @click="submitEpisodio">
//         Salvar Episódio
//       </v-btn>
//     </v-card-text>
//   </v-card>

//   <v-row v-for="(ep, index) in episodiosList" :key="index">
//     <video>{{ ep.episodio }}</video>
//   </v-row>
// </template>

// <script setup>
// import { ref } from 'vue'
// import { useTodoStore } from '@/stores/todoStore'
// import { useRoute } from 'vue-router'

// const store = useTodoStore()
// const route = useRoute()

// const animeId = Number(route.params.id)

// const form = ref({
//   title: '',
//   description: '',
//   episodio: null,
//   videoFile: null,
// })

// const handleFile = (file) => {
//   form.value.videoFile = file
// }

// const submitEpisodio = async () => {
//   if (!form.value.videoFile) {
//     alert('Selecione um arquivo de vídeo!')
//     return
//   }

//   // Upload do vídeo
//   const formData = new FormData()
//   formData.append('video', form.value.videoFile)

//   try {
//     const response = await store.uploadVideo(formData)
//     const videoFileName = response.filename || form.value.videoFile.name

//     // Agora envia os dados do episódio
//     await store.addEpisodios(animeId, {
//       title: form.value.title,
//       description: form.value.description,
//       episodio: form.value.episodio,
//       video: videoFileName,
//     })

//     alert('Episódio adicionado com sucesso!')
//     form.value = { title: '', description: '', episodio: null, videoFile: null }
//   } catch (error) {
//     console.error(error)
//     alert('Erro ao adicionar episódio.')
//   }

//   const episodiosList = ref([
//         "/episodios/SoloLeveling01.mp4", 
//         "/imgs/janela2.jpeg", 
//         "/imgs/janela3One.jpg", 
//         "/imgs/janela4.jpg"
//       ]);
// }
// </script>
  