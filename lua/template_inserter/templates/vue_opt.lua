
local M = {}

function M.get()
	return {
		"<template>",
		'  <div class="app-window">',
		'    <h1>{{ title }}</h1>',
		'    <p>This is a simple Vue window.</p>',
		"  </div>",
		"</template>",
		"",
		"<script>",
		"export default {",
		"  name: 'AppWindow',",
		"  data() {",
		"    return {",
		"      title: 'Vue Window'",
		"    }",
		"  }",
		"}",
		"</script>",
		"",
		"<style scoped>",
		".app-window {",
		"  width: 320px;",
		"  height: 240px;",
		"  border: 2px solid #333;",
		"  border-radius: 8px;",
		"  padding: 16px;",
		"  box-sizing: border-box;",
		"  background-color: #f9f9f9;",
		"}",
		"</style>",
	}
end

return M
