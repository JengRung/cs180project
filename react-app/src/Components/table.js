import React,{useEffect} from "react";
import ReactDOM from "react-dom";
import { makeStyles } from "@material-ui/core/styles";
import Table from "@material-ui/core/Table";
import TablePagination from "@mui/material/TablePagination";
import TableContainer from "@material-ui/core/TableContainer";
import TableBody from "@material-ui/core/TableBody";
import TableCell from "@material-ui/core/TableCell";
import TableHead from "@material-ui/core/TableHead";
import TableRow from "@material-ui/core/TableRow";
import Input from "@material-ui/core/Input";
import Paper from "@material-ui/core/Paper";
import IconButton from "@material-ui/core/IconButton";
// Icons
import DoneIcon from "@material-ui/icons/DoneAllTwoTone";
import RevertIcon from "@material-ui/icons/NotInterestedOutlined";
import animeData from "../anime.json";
import { borderBottom } from "@mui/system";
import "./table.css";


const useStyles = makeStyles((theme) => ({
  root: {
    width: "100%",
    marginTop: theme.spacing(3),
    overflowX: "auto",
    backgroundColor: "#f29133",
  },
  
  table: {
    minWidth: 650,
    
  },
  selectTableCell: {
    width: 60,
  },
  tableCell: {
    width: 130,
    height: 40,
    borderRight: 2,
    borderRightColor: "#f29133",
    borderRightStyle: "solid",
    borderLeft: 2,
    borderLeftColor: "#f29133",
    borderLeftStyle: "solid",
    borderBottom: 2,
    borderBottomColor: "#f29133",
    borderBottomStyle: "solid",
    backgroundColor: "#ffeacd",
  },
  input: {
    width: 130,
    height: 40,
  },
}));

var animeList = [];
let count = 0;
animeData.forEach(function (item) {
  if (count < 10) {
    animeList.push(item);
  }
  count += 1;
});

const CustomTableCell = ({ row, name, onChange }) => {
  const classes = useStyles();
  const { isEditMode } = row;
  return (
    <TableCell align="left" className={classes.tableCell}>
      {isEditMode ? (
        <Input
          value={row[name]}
          name={name}
          onChange={(e) => onChange(e, row)}
          className={classes.input}
        />
      ) : (
        row[name]
      )}
    </TableCell>
  );
};


const AppTable = (props) => {
  const [rows, setRows] = React.useState([]);
  const [previous, setPrevious] = React.useState({});
  const classes = useStyles();

  const [page, setPage] = React.useState(0);
  const [rowsPerPage, setRowsPerPage] = React.useState(10);

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(+event.target.value);
    setPage(0);
  };


  useEffect(()=> {
    (
        
        async () => {
            let animes = {}
            if (props !== undefined && props.match !== undefined && props.match.params !== undefined){
              const response = await fetch(`http://localhost:8000/api/${props.match.params.func}?value=${props.match.params.value}&n=${props.match.params.n}`);
              animes = await response.json();
            }else{
              animes = await (await fetch(`http://localhost:8000/api/topAnimeByStudio?}`)).json();
            }
            setRows(animes)  
          }
    )();
  } ,[]);

  const onChange = (e, row) => {
    if (!previous[row.id]) {
      setPrevious((state) => ({ ...state, [row.id]: row }));
    }
    const value = e.target.value;
    const name = e.target.name;
    const { id } = row;
    const newRows = rows.map((row) => {
      if (row.id === id) {
        return { ...row, [name]: value };
      }
      return row;
    });
    setRows(newRows);
  };

  return (
    <Paper sx={{ width: "100%", overflow: "hidden" }}>
      <TableContainer sx={{ maxHeight: 440 }}>
        <Table sx={{ backgroundColor: "#b53653"}}>
          
          {/* <caption>What a Cool Table, Pog</caption> */}
          <TableHead>
            <TableRow>
              <TableCell align="left">Name</TableCell>
              <TableCell align="left">Score</TableCell>
              <TableCell align="left">Genres</TableCell>
              <TableCell align="left">English&nbsp;name</TableCell>
              <TableCell align="left">Japanese&nbsp;name</TableCell>
              <TableCell align="left">Type</TableCell>
              <TableCell align="left">Episodes</TableCell>
              <TableCell align="left">Studios</TableCell>
              <TableCell align="left">Duration</TableCell>
              <TableCell align="left">Rating</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {rows
              .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage)
              .map((row) => (
                <TableRow key={row.id}>
                  <CustomTableCell {...{ row, name: "Name", onChange }} />
                  <CustomTableCell {...{ row, name: "Score", onChange }} />
                  <CustomTableCell {...{ row, name: "Genres", onChange }} />
                  <CustomTableCell {...{ row, name: "English name", onChange }}/>
                  <CustomTableCell {...{ row, name: "Japanese name", onChange }}/>
                  <CustomTableCell {...{ row, name: "Type", onChange }} />
                  <CustomTableCell {...{ row, name: "Episodes", onChange }} />
                  <CustomTableCell {...{ row, name: "Studios", onChange }} />
                  <CustomTableCell {...{ row, name: "Duration", onChange }} />
                  <CustomTableCell {...{ row, name: "Rating", onChange }} />
                </TableRow>
              ))}
          </TableBody>
        </Table>
        <TablePagination
          rowsPerPageOptions={[10, 25, 100]}
          component="div"
          count={rows.length}
          rowsPerPage={rowsPerPage}
          page={page}
          onPageChange={handleChangePage}
          onRowsPerPageChange={handleChangeRowsPerPage}
        />
      </TableContainer>
    </Paper>
  );
}

const rootElement = document.getElementById("root");

ReactDOM.render(<AppTable />, rootElement);

export default AppTable;