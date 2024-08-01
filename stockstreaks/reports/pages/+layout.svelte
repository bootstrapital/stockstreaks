<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';
	export let data;
</script>

<EvidenceDefaultLayout {data}>

	title="Stock Streaks"
	logo="static/stockstreaks-bars-logo.png"
	neverShowQueries={false}
	maxWidth={1280}
	fullWidth={false}
	hideSidebar={false} 
    hideHeader={true}
    hideBreadcrumbs={false}
	hideTOC={false}
	builtWithEvidence={false}

	<slot slot="content" />
</EvidenceDefaultLayout>