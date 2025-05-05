<template>
  <v-app-bar :elevation="2" color="black" dark>
    <v-row class="d-flex align-center w-100" no-gutters>
      <v-col cols="auto" class="d-flex align-center">
        <v-btn icon @click="Home">
          <v-icon>mdi-arrow-left-bold-outline</v-icon>
        </v-btn>
        <v-card-title>
          <img src="/logo.png" height="50" style="margin-top: 5px;" />
        </v-card-title>
      </v-col>
      <v-col cols="auto" class="d-flex justify-end">
        <v-app-bar-title class="d-none d-md-flex">Yokosu</v-app-bar-title>
      </v-col>
    </v-row>
  </v-app-bar>

  <v-empty-state
    icon="mdi-magnify"
    text="Página ainda em construção, aguarde"
    title="We couldn't find a match."
    style="margin-top: 200px;"
    v-if="episodiosList.length === 0"
  ></v-empty-state>

  <v-main v-else>
    <v-row class="d-flex align-center row" no-gutters>
      <v-col cols="12" md="4" color="black" dark>
        <v-img
          :src="`${anime.image}`"
          height="350"
          class="image-overlay"
          cover
        >
          <template #default>
            <div class="overlay"></div>
          </template>
        </v-img>
      </v-col>
      <v-col cols="12" md="8">
        <v-card-title class="text-h3 title">{{ anime.title }}</v-card-title>
        <v-card-text class="text-body-1 descrition">{{ anime.descrition }}</v-card-text>
        <v-rating
          :length="5"
          :size="38"
          active-color="red"
          half-increments
          hover
          v-model="rating"
        />
      </v-col>
    </v-row>

    <v-divider class="my-1" color="black"></v-divider>

    <h2 class="text-h5 mb-2">Episódios</h2>
    <v-divider class="my-1"></v-divider>

    <v-row dense class="d-flex flex-column">
      <v-col
        v-for="(ep, index) in episodiosList"
        :key="index"
        cols="12"
        class="mb-3"
      >
        <v-card class="pa-2 black-card" elevation="6">
          <v-row>
            <v-col cols="12" md="4">
              <video
                :src="ep.video"
                controls
                muted
                playsinline
                height="120"
                style="width: 100%; border-radius: 8px;"
                @click="expandirVideo($event)"
              >
                Seu navegador não suporta vídeos HTML5.
              </video>
            </v-col>

            <v-col cols="12" md="8">
              <div class="text-white font-weight-bold mb-1">
                Capítulo {{ ep.episodios }}: {{ ep.title }}
                <v-icon v-if="isAssistido(ep)" color="green" class="ml-2">mdi-check-circle</v-icon>
              </div>
              <div class="text-grey-lighten-1 mb-2">{{ ep.description }}</div>

              <!-- Botão para marcar como assistido -->
              <v-btn
                v-if="!isAssistido(ep)"
                @click="marcarComoAssistido(ep)"
                color="primary"
                variant="text"
                icon
              >
                <v-icon>mdi-content-save-all</v-icon>
              </v-btn>
                <v-btn
                  
                  icon
                  variant="text"
                  size="small"
                  @click="desmarcarAssistido(ep)"
                  title="Desmarcar como assistido"
                >
                  <v-icon color="red" size="28">mdi-close-circle</v-icon>
                </v-btn>
              
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-main>
</template>

<script>
  import { useRouter, useRoute } from "vue-router";
  import { computed, ref, watch } from "vue";
  import { useTodoStore } from "../stores/todoStore";

  // Importar listas de episódios por anime
  import soloLevelingEpisodes from "../data/soloLeveling";
  // import chainsawEpisodes from "../data/chainsaw"; (quando criar)

  export default {
    setup() {
      const router = useRouter();
      const route = useRoute();
      const todoStore = useTodoStore();

      const rating = ref(4.5);

      const anime = computed(() => {
        return todoStore.todos.find((todo) => todo.id === Number(route.params.id));
      });

      const episodiosList = ref([]);

      // Preencher a lista correta com base no nome do anime
      watch(anime, (newAnime) => {
        if (!newAnime) return;

        if (newAnime.title === "Solo Leveling") {
          episodiosList.value = soloLevelingEpisodes;
        }
        // Adicione outros animes aqui futuramente
      }, { immediate: true });
      // Exemplo: else if (anime.value?.title === "Chainsaw Man") { episodiosList.value = chainsawEpisodes }

      const expandirVideo = (event) => {
        const videoElement = event.target;

        if (videoElement.requestFullscreen) {
          videoElement.requestFullscreen();
        } else if (videoElement.webkitRequestFullscreen) {
          videoElement.webkitRequestFullscreen();
        } else if (videoElement.msRequestFullscreen) {
          videoElement.msRequestFullscreen();
        }

        if (videoElement.paused) {
          videoElement.play();
        }
      };

      const marcarComoAssistido = (ep) => {
        const animeId = anime.value?.id;
        const epId = `${animeId}-${ep.episodios}`; // exemplo: "1-3"

        todoStore.marcarEpAssistido({
          ...ep,
          id: epId,
          animeId,
          name: anime.value?.title,
        });
      };
      const desmarcarAssistido = (ep) => {
          const animeId = anime.value?.id;
          const epId = `${animeId}-${ep.episodios}`;
          todoStore.desmarcarEpAssistido(epId);
        };


      const isAssistido = (ep) => {
        const animeId = anime.value?.id;
        const epId = `${animeId}-${ep.episodios}`;

        return todoStore.userLogado?.episodiosAssistidos?.some(e => e.id === epId);
      };

      const Home = () => {
        router.push("/home");
      };

      return {
        anime,
        Home,
        expandirVideo,
        marcarComoAssistido,
        rating,
        episodiosList,
        isAssistido,
        desmarcarAssistido,
      };
    },
  };
</script>

<style scoped>
.images {
  transition: transform 0.3s ease-in-out;
  display: flex;
  align-items: end;
}

.images:hover {
  transform: scale(1.08); /* aumenta 5% */
  cursor: pointer;
}

.image-overlay {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  transition: transform 0.3s ease-in-out;
}

.image-overlay:hover {
  transform: scale(1.05);
  cursor: pointer;
}

.overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(to bottom, rgba(0, 0, 0, 0.4), rgba(0, 0, 0, 0.7));
  z-index: 1;
}

.row {
  background-color: rgba(0, 0, 0, 0.767);
}

.title {
  color: white;
}

.descrition {
  color: white;
}

.black-card {
  background-color: #121212;
  border-radius: 12px;
  transition: transform 0.2s ease-in-out;
}

.black-card:hover {
  transform: scale(1.01);
}
</style>
