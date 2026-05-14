const express = require('express');
const { Pool } = require('pg');
const app = express();

app.use(express.json());
app.use(express.static('.')); // Serves your luxury gold/dark blue index.html file

// Establish connection to our new local PostgreSQL engine
const pool = new Pool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: parseInt(process.env.DB_PORT, 10)
});


// Dynamic API Endpoint to parse available genres from our database rows
app.get('/api/genres', async (req, res) => {
    try {
        const result = await pool.query('SELECT DISTINCT UNNEST(genres) as genre FROM books ORDER BY genre');
        const genres = result.rows.map(row => row.genre);
        res.json(genres);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Local database connection error" });
    }
});

// Recommendation handler pulling parameters directly from user frontend submission
app.post('/api/recommendations', async (req, res) => {
    const { genres, minRating, yearRange } = req.body;
    try {
        const query = `
            SELECT *, 
            (rating * 2) as score 
            FROM books 
            WHERE rating >= $1 
              AND year >= $2 
              AND year <= $3
        `;
        const result = await pool.query(query, [minRating, yearRange[0], yearRange[1]]);
        
        // Filter elements based on whether they contain any selected user genres
        const filteredBooks = result.rows.filter(book => 
            genres.some(g => book.genres.includes(g))
        );
        
        res.json(filteredBooks);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Query execution error" });
    }
});

app.listen(3000, () => console.log('Bookstore Engine connecting locally on Port 3000'));
