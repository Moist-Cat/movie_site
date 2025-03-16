export const fetchData = async (url) => {
    let api = process.env.REACT_APP_API_URL;
    if (api === undefined) {
        api = "http://localhost:5051";
    }

  const response = await fetch(api + url);
  
  if (!response.ok) {
    throw new Error('Failed to fetch');
  }

  const data = await response.json();

  return { data };
};

