const weekDaysTemplate = DateHelper => ({
    name: 'weekday',
    parent: 'day',
    rowsCount: () => 5,
    columnsCount: () => 54,
    mapping: (startTimestamp, endTimestamp) => {
      let weekNumber = 0;
      let x = -1;
  
      return DateHelper.intervals(
        'day',
        startTimestamp,
        DateHelper.date(endTimestamp)
      )
        .map(ts => {
          const date = DateHelper.date(ts);
  
          if (weekNumber !== date.week()) {
            weekNumber = date.week();
            x += 1;
          }
  
          if (date.format('d') === '0' || date.format('d') === '6') {
            return null;
          }
  
          return {
            t: ts,
            x,
            y: date.format('d') - 1,
          };
        })
        .filter(n => n !== null);
    },
  });

// async function logJSONData() {
//     const response = await fetch('http://127.0.0.1:8000/api/v0/stocks/amzn/calcs');
//     const jsonData = await response.json();
//     console.log(jsonData.slice(0,5));
// }

const response = await fetch('http://127.0.0.1:8000/api/v0/stocks/amzn/calcs');
const jsonData = await response.json();

const cal = new CalHeatmap();
cal.addTemplates(weekDaysTemplate);
cal.paint(
    {
        verticalOrientation: true,
        date: {
            min: new Date('2018-01-01'),
            start: new Date('2020-01-01'),
            max: new Date('2023-05-01'),
            highlight: [
                // new Date('2020-01-15'),
                new Date('2023-04-26'), // Highlight today
            ],
        },
        data: { 
            source: 'http://127.0.0.1:8000/api/v0/stocks/amzn/calcs', 
            x: d => d['date'], 
            y: d => d['isClosedAboveOpen'],
        },
        // range: 2,
        domain: { 
            type: 'year',
            // label: { textAlign: 'middle', position: 'left' },
            // gutter: 1,
        },
        subDomain: { 
            type: 'weekday', 
            label: 'D', 
            width: 20, 
            height: 20,
            radius: 3,
            // gutter: 2,
        },
        scale: {
            color: {
            type: 'categorical',
            scheme: 'RdBu',
            pivot: 0,
            symmetric: true,
            domain: [0, 1],
            },
        },
        itemSelector: '#cal-heatmap',
    },
    [
        // [
        //     Legend
        // ],
        [Tooltip],
        [
            CalendarLabel,
            {
              width: 30,
              textAlign: 'start',
              position: 'left',
              text: () => dayjs.weekdaysShort().map((d, i) => (i === 0 || i === 6 ? '' : d)),
              padding: [-20, 0, 0, 0],
            },
        ],
    ]
);
