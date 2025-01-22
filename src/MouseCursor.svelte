<script>
	import { Cursor } from 'svelte-cursor';
</script>

<Cursor>
	<!-- svelte-ignore element_invalid_self_closing_tag -->
	<div class="cursor" />
</Cursor>

<style>
    .cursor {
	width: 20px;
	aspect-ratio: 1;
	background-color: white;
	border-radius: 50%;
}
</style>