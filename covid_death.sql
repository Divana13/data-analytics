-- See the dataset
SELECT *
FROM covidproject.coviddeaths

-- Checking for percentage of infected for each location
SELECT continent, location,MAX(population) as population, MAX(total_cases) AS total_cases, MAX(total_cases) / MAX(population) * 100 AS percentage_infected
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location

-- Checking total cases by continent
WITH ContinentInfected AS(
SELECT continent, location,MAX(population) as population, MAX(total_cases) AS total_cases, MAX(total_cases) / MAX(population) * 100 AS percentage_infected
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
)
SELECT continent, SUM(population) AS continent_population, SUM(total_cases) AS continent_cases, SUM(total_cases) / SUM(population) * 100 AS in_percentage
FROM ContinentInfected
GROUP BY continent

-- Checking for percentage of new cases to total_cases each day
SELECT continent, location, date, total_cases, new_cases, new_cases / total_cases * 100 AS in_percentage
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL

-- Checking out for total death by location
SELECT continent, location, MAX(total_deaths) AS tatal_deaths
FROM covidproject.coviddeaths
WHERE continent IS NOt NULL
GROUP BY location

-- Checking out percentage of deaths compare to population
SELECT continent, location, MAX(population) AS population, MAX(total_deaths) AS total_deaths, MAX(total_deaths) / MAX(population) * 100 AS in_percentage
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY in_percentage DESC

-- Checking total deaths by continent
WITH ContinentDeaths AS (
SELECT continent, location, MAX(population) AS population, MAX(total_deaths) AS total_deaths, MAX(total_deaths) / MAX(population) * 100 AS in_percentage
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
)
SELECT continent, SUM(population) AS continent_population, SUM(total_deaths) AS continent_deaths, SUM(total_deaths) / SUM(population) * 100 in_percentage
FROM ContinentDeaths
GROUP BY continent
ORDER BY in_percentage DESC

-- Highest death of all time
SELECT continent, location, date, population, total_cases, total_deaths, new_deaths, new_deaths / population * 100 AS percentage_in_population, new_deaths / total_cases * 100 AS percentage_in_TotalCases, new_deaths / total_deaths * 100 AS percentage_in_TotalDeaths
FROM covidproject.coviddeaths
WHERE new_deaths = (
	SELECT MAX(new_deaths)
	FROM covidproject.coviddeaths
	WHERE continent IS NOT NULL
)

-- Checking to see if there are any values data for thoses who are in ICU and Hopital
SELECT continent, location, MAX(total_cases) AS total_cases, MAX(total_deaths) AS total_death, MAX(icu_patients) AS icu_patients, MAX(hosp_patients) AS hosp_patients
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
	-- After checking most country did not provide data of how much infected were in ICU and Hospital
	
-- Create view for continent deaths
CREATE VIEW ContinentDeaths AS
WITH ContinentDeaths AS (
SELECT continent, location, MAX(population) AS population, MAX(total_deaths) AS total_deaths, MAX(total_deaths) / MAX(population) * 100 AS in_percentage
FROM covidproject.coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
)
SELECT continent, SUM(population) AS continent_population, SUM(total_deaths) AS continent_deaths, SUM(total_deaths) / SUM(population) * 100 in_percentage
FROM ContinentDeaths
GROUP BY continent
ORDER BY in_percentage DESC