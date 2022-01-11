import "./FeatureBar.css";
import React, {useState} from "react";

export default FeatureBar;
function FeatureBar({func,n,placeholder, data}) {

    const [filteredData, setFilteredData] = useState([]);
    const handleFilter = (event) => {
        const searchWord = event.target.value;
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
        <div className="searchF">
            <div className="searchInputsF">
                <input type="text" placeholder={placeholder} onChange={handleFilter}/>

            </div>
            
        {filteredData.length != 0 && (
            <div className="resultsF">
                {filteredData.map((value, key) => {
                    return (
                        <a className="dataItem" href={"http://localhost:3000/table/" + func + "/" + value + "/" + n } target="_blank">
                            <p>{value}</p>
                        </a>
                    );
                })}
            </div>
        )}    
        </div>
    );
}

