<template>
  <button
    :type="type"
    class="bt"
    :class="[`${variant}`, `${size}`]" 
    :disabled="disabled"
    @click="emit('click', $event)"
  >
    <slot />
  </button>
</template>

<script setup>
defineProps({
  variant: { type: String, default: "bt-basic" },
  size: { type: String, default: "bt-normal" },
  type: { type: String, default: "button" },
  disabled: { type: Boolean, default: false }
})

const emit = defineEmits(["click"])
</script>

<style scoped>

.bt { 
  padding: 0.75rem 1rem;
  border: 0; 
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
  font-size: 0.9rem;
  height: 2.5rem;
  overflow: hidden;
}

.bt-normal { 
  background: var(--primary-color);
  border: 1px solid var(--primary-color);
  color: #ffffff;
  width: 12rem;
}

.bt-normal:hover {
  background: var(--primary-color-dark);
  border-color: var(--primary-color-dark); 

}

.bt-large { 
  padding: 20px 100px; 
  font-size: 14px; 
}

.bt-basic { 
  background: var(--primary-color); 
  color: white; 
}

.bt-replay{ 
  background: #e5e7eb; 
  color: #111827; 
}

.bt-danger { 
  background: var(--danger-color); 
  color: white; 
}

.bt:disabled { 
  opacity: 0.6; 
  cursor: not-allowed; 
  } 

</style>
