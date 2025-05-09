<template>
  <v-app-bar flat height="250" class="pa-0" style="overflow: hidden">
    <v-img src="https://picsum.photos/1200/250" cover height="250">
      <v-container
        class="fill-height d-flex flex-column justify-end"
        style="background: rgba(0, 0, 0, 0.4)"
      >
        <!-- Botão no topo -->
        <v-btn
          class="ma-2"
          small
          color="primary"
          style="position: absolute; top: 10px; right: 10px"
        >
          Alterar capa
        </v-btn>

        <!-- Linha com avatar, nome e botão -->
        <v-row align="center" class="ma-2">
          <v-col cols="auto">
            <v-avatar size="100" image="/imgs/Nanatsu.jpg" />
          </v-col>
          <v-col>
            <div class="d-flex align-center">
              <h2 class="text-white mr-2">
                {{ todoStore.userLogado?.name || "Usuário não logado" }}
              </h2>
              <v-btn icon small>
                <v-icon class="text-white">mdi-pencil</v-icon>
              </v-btn>
            </div>
          </v-col>
        </v-row>
      </v-container>
    </v-img>
  </v-app-bar>

  <v-container>
    <main style="margin-top: 240px">
      <v-row class="text-center">
        <v-col>
          <v-icon>mdi-playlist-play</v-icon>
          <div>Total de animes</div>
        </v-col>
        <v-col>
          <v-icon>mdi-clock</v-icon>
          <div>Horas assistidas</div>
        </v-col>
        <v-col>
          <v-icon>mdi-heart</v-icon>
          <div>Favoritos</div>
        </v-col>
      </v-row>
      <br />
      <v-cols
        v-for="(ep, index) in todoStore.userLogado?.episodiosAssistidos || []"
        :key="index"
        class="mb-2"
      >
        <v-card class="episodios">
          <h3>Animes Assistidos</h3>

          <v-card-title>
            {{ ep.name || "Anime desconhecido" }}
          </v-card-title>
          <v-card-subtitle>Capítulo {{ ep.episodios }}: {{ ep.title }}</v-card-subtitle>
          <v-btn class="ma-2" color="info">Continar</v-btn>
        </v-card>
      </v-cols>
      <!-- <v-list>
        <v-list-item v-for="atv in atividadesRecentes" :key="atv.id">
          <v-list-item-icon><v-icon>mdi-history</v-icon></v-list-item-icon>
          <v-list-item-content>{{ atv.texto }}</v-list-item-content>
        </v-list-item>
      </v-list> -->

      <v-btn class="btn" color="error" @click="sair">Sair</v-btn>
    </main>
  </v-container>
</template>

<script>
import { useTodoStore } from "@/stores/todoStore";
import { computed } from "vue";
import TodoLogin from "@/components/TodoLogin.vue";
import AnimeDetailsView from "../views/AnimeDetailsView.vue";
import { useRouter } from "vue-router";

export default {
  components: { TodoLogin, AnimeDetailsView },
  setup() {
    const todoStore = useTodoStore();
    const usuarios = todoStore.usuarios;
    const router = useRouter();

    const useEdit = computed(() => {
      return todoStore.userLogado ? todoStore.userLogado : null;
    });

    const marcarComoAssistido = (ep) => {
      ep.assistido = true;
    };

    const sair = () => {
      router.push("home");
    };

    return {
      usuarios,
      useEdit,
      todoStore,
      marcarComoAssistido,
      sair,
    };
  },
};
</script>

<style>
.conta {
  background-color: rgba(85, 77, 77, 0.1);
}
.btn {
  color: red;
  transition: all 0.4s;
}
.btn:hover {
  background-color: black;
}

.tipos {
  display: flex;
  text-align: center;
}
.episodios {
  border-radius: 10px;
  width: 30rem;
}
</style>
