import * as React from 'react';
import Box from '@mui/material/Box';
import TextField from '@mui/material/TextField';
import Button from '@mui/material/Button';
import Stack from '@mui/material/Stack';
import './AnimeChange.css';
export default function AnimeChange() {

  const [values, setValues] = React.useState({
    animeName: '',
    score: '',
    ranking: '',
    episodes: '',
    type: '',
    popularity: '',
    genre: '',
    studio: '',
  });
  const handleChange = (prop) => (event) => {
    setValues({ ...values, [prop]: event.target.value });
  };
  function animeEdit(event) {
    event.preventDefault();
    window.open(
      'http://127.0.0.1:8000/api/animeEdit?name='+ values.animeName + '&score=' + values.score + '&ranking=' + values.ranking + '&episode=' + values.episodes + '&genre=' + values.genre + '&popularity=' + values.popularity+ '&type=' + values.type + '&studio=' + values.studio,
      '_blank'
    );
  };
  function animeDelete(event) {
    event.preventDefault();
    window.open(
      'http://127.0.0.1:8000/api/animeDelete?name=' + values.animeName,
      '_blank'
    );
  };
  function animeAdd(event) {
    event.preventDefault();
    window.open(
      'http://127.0.0.1:8000/api/animeAdd?name='+ values.animeName + '&score=' + values.score + '&ranking=' + values.ranking + '&episode=' + values.episodes + '&genre=' + values.genre + '&popularity=' + values.popularity+ '&type=' + values.type + '&studio=' + values.studio,
      '_blank'
    );
  };
  function animeBackup(event){
    event.preventDefault();
    window.open(
      'http://127.0.0.1:8000/api/backup',
      '_blank'
    );
  };
  function animeImport(event){
    event.preventDefault();
    window.open(
      'http://127.0.0.1:8000/api/import',
      '_blank'
    );
  };

  return (
    <div>
    <Box
      component="form"
      sx={{
        '& .MuiTextField-root': { m: 1, width: '25ch' },
      }}
      noValidate
      autoComplete="off"
    >
      <div class="modify">
        <TextField
          id="outlined-multiline-flexible"
          label="Anime Name"
          multiline
          maxRows={4}
          value={values.animeName}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('animeName')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Score"
          multiline
          maxRows={4}
          value={values.score}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('score')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Ranking"
          multiline
          maxRows={4}
          value={values.ranking}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('ranking')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Episodes"
          multiline
          maxRows={4}
          value={values.episodes}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('episodes')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Type"
          multiline
          maxRows={4}
          value={values.type}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('type')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Popularity"
          multiline
          maxRows={4}
          value={values.popularity}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('popularity')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Genre"
          multiline
          maxRows={4}
          value={values.genre}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('genre')}
        />
        <TextField
          id="outlined-multiline-flexible"
          label="Studio"
          multiline
          maxRows={4}
          value={values.studio}
          style={{
            backgroundColor: "blanchedalmond",
            borderRadius: 5,
            width: 400,
          }}
          onChange={handleChange('studio')}
        />

      </div>

      <div class="container">
        <Stack spacing={2} direction="row" 
          style={{
            marginLeft: "-1%"
          }}>
        <Button onClick={animeEdit}
                style={{
                  backgroundColor: "#f39133",
                }}
                variant="contained">Edit</Button>
        <Button onClick={animeDelete}
                style={{
                  backgroundColor: "#f39133",
                }}
                variant="contained">Delete</Button>
        <Button onClick={animeAdd}
                style={{
                  backgroundColor: "#f39133",
                }}
                variant="contained">Add</Button>
        <Button onClick={animeBackup}
                style={{
                  backgroundColor: "#f39133",
                }}
                variant="contained">Backup</Button>
        <Button onClick={animeImport}
                style={{
                  backgroundColor: "#f39133",
                }}
                variant="contained">Import</Button>

        </Stack>
      </div>
    </Box>
    
    <div class="font">
        <form action="http://localhost:3000/" > 
          <button class="backButton">
            <img class="img" src='https://c.tenor.com/UT8tOhIfbdUAAAAj/anime-daling-in-the-franxx.gif' style={{
              backgroundColor: "none",
              borderRadius: 5,
            }}/>
          </button>
        </form>
            Press me to go back!
      </div>
    </div>
  );
}
