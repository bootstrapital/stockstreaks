// static/js/main.js
document.addEventListener('DOMContentLoaded', function () {
    // Hamburger menu toggle
    const hamburger = document.querySelector('.hamburger-menu');
    const navUl = document.querySelector('.main-nav ul');

    if (hamburger && navUl) {
        hamburger.addEventListener('click', () => {
            navUl.classList.toggle('active');
        });
    }

    // Ticker Search Form (Client-side redirect)
    const searchForm = document.getElementById('tickerSearchForm');
    if (searchForm) {
        searchForm.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent default form submission
            const tickerInput = document.getElementById('tickerSearchInput');
            const symbol = tickerInput.value.trim().toUpperCase();
            if (symbol) {
                window.location.href = `/ticker/${symbol}`;
            }
        });
    }


    // Chart.js - Price Performance Chart
    const chartCanvas = document.getElementById('pricePerformanceChart');
    if (chartCanvas && typeof tickerChartData !== 'undefined' && tickerChartData.labels && tickerChartData.prices) {
        // tickerChartData should be provided by the template, containing labels (dates) and prices
        // Example: <script> const tickerChartData = {{ ticker.priceHistory30DayJS | safe }}; </script>

        const data = {
            labels: tickerChartData.labels, // e.g., ["May 01", "May 02", ...]
            datasets: [{
                label: 'Price',
                backgroundColor: function(context) { // Gradient fill [cite: 64]
                    const chart = context.chart;
                    const {ctx, chartArea} = chart;
                    if (!chartArea) { return null; } // Graceful exit if chartArea is not defined
                    const gradient = ctx.createLinearGradient(0, chartArea.bottom, 0, chartArea.top);
                    gradient.addColorStop(0, 'rgba(22, 163, 74, 0.05)'); // [cite: 64]
                    gradient.addColorStop(1, 'rgba(22, 163, 74, 0.6)'); // [cite: 64]
                    return gradient;
                },
                borderColor: '#10B981', // Line color: Accent green [cite: 63] (using #10B981 from theme)
                borderWidth: 2,
                data: tickerChartData.prices, // e.g., [100.50, 101.20, ...]
                fill: true, // For area chart
                pointRadius: 3, // Small circular points [cite: 65]
                pointBackgroundColor: '#10B981',
                pointBorderColor: '#ffffff',
                pointHoverRadius: 5,
                tension: 0.1 // For slight curve in line
            }]
        };

        const config = {
            type: 'line',
            data: data,
            options: {
                responsive: true, // [cite: 68]
                maintainAspectRatio: false, // Allows better control with CSS for height
                scales: {
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: function(value, index, values) {
                                return '$' + value.toFixed(2); // Currency format [cite: 65]
                            },
                            color: '#D1D5DB' // Light Gray for Y-axis text
                        },
                        grid: {
                            color: '#374151' // Subtle dark grid lines [cite: 66]
                        }
                    },
                    x: {
                        ticks: {
                            color: '#D1D5DB' // Light Gray for X-axis text
                            // autoSkip: true,
                            // maxTicksLimit: 10 // Adjust for readability
                        },
                        grid: {
                            display: false // Grid lines hidden or very subtle for X-axis [cite: 66]
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false // Hide legend if only one dataset
                    },
                    tooltip: { // Tooltip on hover [cite: 67]
                        enabled: true,
                        mode: 'index',
                        intersect: false,
                        callbacks: {
                            // Customize tooltip content if needed
                            // title: function(tooltipItems) { return tooltipItems[0].label; },
                            // label: function(tooltipItem) {
                            //    let label = tooltipItem.dataset.label || '';
                            //    if (label) { label += ': '; }
                            //    if (tooltipItem.parsed.y !== null) {
                            //        label += '$' + tooltipItem.parsed.y.toFixed(2);
                            //    }
                            //    // Add daily change here if data is available
                            //    return label;
                            // }
                        }
                    }
                },
                interaction: {
                    mode: 'index',
                    intersect: false,
                }
            }
        };

        new Chart(chartCanvas, config);
    } else if (chartCanvas) {
        console.warn("Chart canvas found, but tickerChartData is not defined or incomplete.");
    }
});
