import{s as $,a as g,e as d,b as S,c as b,h as F,d as _,f as u,g as c,i as p,j as k,t as x,k as I,l as N,n as v}from"../chunks/scheduler.BnnKGQZ_.js";import{S as q,i as w,c as A,a as O,m as L,t as H,b as U,d as R}from"../chunks/index.CZcT0KoH.js";import"../chunks/VennDiagram.svelte_svelte_type_style_lang.2Y8qk8D7.js";import"../chunks/index.kWrU6Xq4.js";import"../chunks/entry.CaBaf316.js";import{C as j}from"../chunks/CodeBlock.CocX2R0R.js";function G(y){var i;let o,m=(n.title??((i=n.og)==null?void 0:i.title))+"",e;return{c(){o=d("h1"),e=x(m),this.h()},l(s){o=_(s,"H1",{class:!0});var r=I(o);e=N(r,m),r.forEach(u),this.h()},h(){c(o,"class","title")},m(s,r){p(s,o,r),k(o,e)},p:v,d(s){s&&u(o)}}}function K(y){return{c(){this.h()},l(o){this.h()},h(){document.title="Evidence"},m:v,p:v,d:v}}function P(y){var r;let o,m,e,i,s;return document.title=o=n.title??((r=n.og)==null?void 0:r.title),{c(){m=g(),e=d("meta"),i=g(),s=d("meta"),this.h()},l(t){m=b(t),e=_(t,"META",{property:!0,content:!0}),i=b(t),s=_(t,"META",{name:!0,content:!0}),this.h()},h(){var t,a;c(e,"property","og:title"),c(e,"content",((t=n.og)==null?void 0:t.title)??n.title),c(s,"name","twitter:title"),c(s,"content",((a=n.og)==null?void 0:a.title)??n.title)},m(t,a){p(t,m,a),p(t,e,a),p(t,i,a),p(t,s,a)},p(t,a){var T;a&0&&o!==(o=n.title??((T=n.og)==null?void 0:T.title))&&(document.title=o)},d(t){t&&(u(m),u(e),u(i),u(s))}}}function X(y){var s,r;let o,m,e=(n.description||((s=n.og)==null?void 0:s.description))&&Y(),i=((r=n.og)==null?void 0:r.image)&&D();return{c(){e&&e.c(),o=g(),i&&i.c(),m=S()},l(t){e&&e.l(t),o=b(t),i&&i.l(t),m=S()},m(t,a){e&&e.m(t,a),p(t,o,a),i&&i.m(t,a),p(t,m,a)},p(t,a){var T,C;(n.description||(T=n.og)!=null&&T.description)&&e.p(t,a),(C=n.og)!=null&&C.image&&i.p(t,a)},d(t){t&&(u(o),u(m)),e&&e.d(t),i&&i.d(t)}}}function Y(y){let o,m,e,i,s;return{c(){o=d("meta"),m=g(),e=d("meta"),i=g(),s=d("meta"),this.h()},l(r){o=_(r,"META",{name:!0,content:!0}),m=b(r),e=_(r,"META",{property:!0,content:!0}),i=b(r),s=_(r,"META",{name:!0,content:!0}),this.h()},h(){var r,t,a;c(o,"name","description"),c(o,"content",n.description??((r=n.og)==null?void 0:r.description)),c(e,"property","og:description"),c(e,"content",((t=n.og)==null?void 0:t.description)??n.description),c(s,"name","twitter:description"),c(s,"content",((a=n.og)==null?void 0:a.description)??n.description)},m(r,t){p(r,o,t),p(r,m,t),p(r,e,t),p(r,i,t),p(r,s,t)},p:v,d(r){r&&(u(o),u(m),u(e),u(i),u(s))}}}function D(y){let o,m,e;return{c(){o=d("meta"),m=g(),e=d("meta"),this.h()},l(i){o=_(i,"META",{property:!0,content:!0}),m=b(i),e=_(i,"META",{name:!0,content:!0}),this.h()},h(){var i,s;c(o,"property","og:image"),c(o,"content",(i=n.og)==null?void 0:i.image),c(e,"name","twitter:image"),c(e,"content",(s=n.og)==null?void 0:s.image)},m(i,s){p(i,o,s),p(i,m,s),p(i,e,s)},p:v,d(i){i&&(u(o),u(m),u(e))}}}function z(y){var M;let o,m,e,i,s,r,t,a=typeof n<"u"&&(n.title||((M=n.og)==null?void 0:M.title))&&n.hide_title!==!0&&G();function T(l,f){var Q;return typeof n<"u"&&(n.title||(Q=n.og)!=null&&Q.title)?P:K}let E=T()(y),h=typeof n=="object"&&X();return r=new j({props:{source:`

<script context="module"> <\/script>

<script>
        import { page } from '$app/stores';
        import { pageHasQueries, routeHash, toasts } from '@evidence-dev/component-utilities/stores';
        import { setContext, getContext, beforeUpdate, onDestroy, onMount } from 'svelte';
		import { writable, get } from 'svelte/store';
        
        // Functions
        import { fmt } from '@evidence-dev/component-utilities/formatting';

		import { CUSTOM_FORMATTING_SETTINGS_CONTEXT_KEY, INPUTS_CONTEXT_KEY } from '@evidence-dev/component-utilities/globalContexts';		
        
        let props;
        export { props as data }; // little hack to make the data name not overlap
        let { data = {}, customFormattingSettings, __db, inputs } = props;
        $: ({ data = {}, customFormattingSettings, __db } = props);

        $routeHash = '6666cd76f96956469e7be39d750cc7d9';

		
		let inputs_store = writable(inputs);
		
		setContext(INPUTS_CONTEXT_KEY, inputs_store);
		onDestroy(inputs_store.subscribe((value) => inputs = value));

        $: pageHasQueries.set(Object.keys(data).length > 0);

        setContext(CUSTOM_FORMATTING_SETTINGS_CONTEXT_KEY, {
            getCustomFormats: () => {
                return customFormattingSettings.customFormats || [];
            }
        });

		import { browser, dev } from "$app/environment";
		import { profile } from '@evidence-dev/component-utilities/profile';
		import debounce from 'debounce';
		import { Query, hasUnsetValues } from '@evidence-dev/sdk/usql';
		import { setQueryFunction } from '@evidence-dev/component-utilities/buildQuery';

		if (!browser) {
			onDestroy(() => Query.emptyCache());
		}

		const queryFunc = (query, query_name) => profile(__db.query, query, { query_name });
		setQueryFunction(queryFunc);

		const scoreNotifier = !dev? () => {} : (info) => {
			toasts.add({
				id: Math.random(),
				title: info.id,
				message: \`Results estimated to use \${
					Intl.NumberFormat().format(info.score / (1024 * 1024))
				}mb of memory, performance may be impacted\`,
				status: 'warning'
			}, 5000);
		};

		
		let inflightQueryTimeout
		const onInflightQueriesStart = () => {
			if (!inflightQueryTimeout) inflightQueryTimeout = setTimeout(() => {
				toasts.add({
					id: 'LoadingToast',
					title: '',
					message: 'Loading...',
					status: 'info'
				}, 0); // timeout of 0 means forever
			}, 3000)
		}
		const onInflightQueriesEnd = () => {
			if (inflightQueryTimeout) {
				clearTimeout(inflightQueryTimeout)
				inflightQueryTimeout = null
			}
			else toasts.dismiss('LoadingToast')
		}
		onMount(() => {
			Query.addEventListener('inFlightQueryStart', onInflightQueriesStart)
			Query.addEventListener('inFlightQueryEnd', onInflightQueriesEnd)
			if (Query.QueriesLoading) {
				onInflightQueriesStart()
			}
			return () => {
				Query.removeEventListener('inFlightQueryStart', onInflightQueriesStart)
				Query.removeEventListener('inFlightQueryEnd', onInflightQueriesEnd)
			}
		})

		if (import.meta?.hot) {
            if (typeof import.meta.hot.data.hmrHasRun === 'undefined') import.meta.hot.data.hmrHasRun = false

			import.meta.hot.on("evidence:reset-queries", async (payload) => {
				await $page.data.__db.updateParquetURLs(JSON.stringify(payload.latestManifest), true);
				Query.emptyCache()
				
			})
	    }
		
		let params = $page.params;
		$: params = $page.params;
		
		let _mounted = false;
		onMount(() => (_mounted = true));

        
     <\/script>

`,copyToClipboard:"true",language:"sql"}}),{c(){a&&a.c(),o=g(),E.c(),m=d("meta"),e=d("meta"),h&&h.c(),i=S(),s=g(),A(r.$$.fragment),this.h()},l(l){a&&a.l(l),o=b(l);const f=F("svelte-1j2izld",document.head);E.l(f),m=_(f,"META",{name:!0,content:!0}),e=_(f,"META",{name:!0,content:!0}),h&&h.l(f),i=S(),f.forEach(u),s=b(l),O(r.$$.fragment,l),this.h()},h(){c(m,"name","twitter:card"),c(m,"content","summary"),c(e,"name","twitter:site"),c(e,"content","@evidence_dev")},m(l,f){a&&a.m(l,f),p(l,o,f),E.m(document.head,null),k(document.head,m),k(document.head,e),h&&h.m(document.head,null),k(document.head,i),p(l,s,f),L(r,l,f),t=!0},p(l,[f]){var Q;typeof n<"u"&&(n.title||(Q=n.og)!=null&&Q.title)&&n.hide_title!==!0&&a.p(l,f),E.p(l,f),typeof n=="object"&&h.p(l,f)},i(l){t||(H(r.$$.fragment,l),t=!0)},o(l){U(r.$$.fragment,l),t=!1},d(l){l&&(u(o),u(s)),a&&a.d(l),E.d(l),u(m),u(e),h&&h.d(l),u(i),R(r,l)}}}const n={hide_title:!0};class et extends q{constructor(o){super(),w(this,o,null,z,$,{})}}export{et as component};
