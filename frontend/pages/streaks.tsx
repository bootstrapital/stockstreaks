import {
  Card,
  Table,
  TableHead,
  TableRow,
  TableHeaderCell,
  TableBody,
  TableCell,
  Text,
  Title,
  Badge,
} from "@tremor/react";

type StreakProps = {
  symbol: string,
  streak_id: number,
  length: number,
  start_date: string,
  end_date: string
}

export async function getServerSideProps() {
  // Fetch data from an external API
  const res = await fetch('http://127.0.0.1:8000/api/v0/stocks/amzn/streaks');
  const data: StreakProps[] = await res.json();

  // Pass data to the page component as props
  return { props: { data } };
}

export default function Streaks({ data }: {data: StreakProps[]}) {
  return (
    <Card>
      <Title>Streaks</Title>
      <Table className="mt-5">
        <TableHead>
          <TableRow>
            <TableHeaderCell>Stock</TableHeaderCell>
            <TableHeaderCell>Start Date</TableHeaderCell>
            <TableHeaderCell>End Date</TableHeaderCell>
            <TableHeaderCell>Streak</TableHeaderCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {data.map((item) => (
            <TableRow key={item.symbol}>
              <TableCell>{item.symbol.toUpperCase()}</TableCell>
              <TableCell>
                <Text>{item.start_date}</Text>
              </TableCell>
              <TableCell>
                <Text>{item.end_date}</Text>
              </TableCell>
              <TableCell>
                <Badge color="emerald">
                  {item.length}
                </Badge>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </Card>
  );
}
