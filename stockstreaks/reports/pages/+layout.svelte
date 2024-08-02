<script>
	import '@evidence-dev/tailwind/fonts.css';
	import '../app.css';
	import { EvidenceDefaultLayout } from '@evidence-dev/core-components';

	export let data;
</script>

<EvidenceDefaultLayout {data}
	title="Stock Streaks"
	logo="/logo.png"
	neverShowQueries={true}
	fullWidth={false}
	hideSidebar={true} 
    hideHeader={false}
    hideBreadcrumbs={true}
	hideTOC={true}
	builtWithEvidence={true}
>
	<slot slot="content" />
</EvidenceDefaultLayout>