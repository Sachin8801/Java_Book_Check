CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genres TEXT[],
    rating NUMERIC(2,1),
    year INT
);

INSERT INTO books (title, author, genres, rating, year) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', ARRAY['classic', 'literary fiction', 'romance'], 4.2, 1925),
('1984', 'George Orwell', ARRAY['dystopian', 'science fiction', 'classic'], 4.5, 1949),
('Dune', 'Frank Herbert', ARRAY['science fiction', 'fantasy', 'adventure'], 4.7, 1965),
('Pride and Prejudice', 'Jane Austen', ARRAY['classic', 'romance', 'literary fiction'], 4.3, 1813),
('The Hobbit', 'J.R.R. Tolkien', ARRAY['fantasy', 'adventure', 'classic'], 4.6, 1937),
('IT by Design', 'Shelby Singh', ARRAY['dystopian'], 4.0, 2022),
('New age IT infra', 'Shelby Kumar Singh', ARRAY['fantasy', 'adventure', 'classic'], 4.0, 2022);