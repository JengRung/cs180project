import React, {useState} from "react";
import './ScoreGallery.css';
import Grid from '@mui/material/Grid';
import AnimeCard from '../Components/AnimeCard';



export default ScoreGallery;
const anime_names = ['anime_1', 'anime_2', 'anime_3', 'anime_4', 'anime_5']

function ScoreGallery({placeholder, data}){
    const [filteredData, setFilteredData] = useState([]);
    const handleFilter = (event) => {
        const searchWord = event.target.value;
        console.log("s:",searchWord)
        console.log("d:",data)
        if(data !== undefined){
            const predetermineWord = data.filter((value) => {
    
                return value !== undefined && value.toLowerCase().includes(searchWord.toLowerCase());
            });
            if (searchWord === "") {
                setFilteredData([]);
            }
            else {
                setFilteredData(predetermineWord);
            }
        }
    }

    return (
        <div>
            <Grid
                container
                direction="row"
                justifyContent="flex-start"
                alignItems="center"
            >
                {anime_names.map(elem => (
                    <Grid item xs={3} md={2}>
                        <AnimeCard cardName={elem}>
                        </AnimeCard>
                    </Grid>
                ))}
            </Grid>
        </div>
    );
}