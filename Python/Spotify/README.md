
### 
# 🎵 Spotify Top Tracks Data Analysis  
**Author:** Sri Durga Bhavani Gude  

This project connects to your Spotify account using the Spotify Web API to fetch your top 10 tracks, save them into a CSV file, and visualize the data using Matplotlib. It's a great hands-on beginner project to understand working with APIs, authentication, and basic data visualization.

---

## 🛠️ Technologies Used
- Python
- Spotipy (Spotify API wrapper)
- Pandas
- Matplotlib
- Jupyter Notebook

---

## 📌 Project Goals
- Connect with Spotify API and authenticate user
- Fetch top 10 Spotify tracks
- Convert the data into a structured DataFrame
- Save it to a CSV file
- Visualize popularity using Matplotlib

---

## 📂 Project Structure

```

SpotifyProject/
│
├── Spotifyplaylist.ipynb         ← Main notebook with all steps
├── your\_spotify\_top\_tracks.csv   ← Output file
├── README.md                     ← You're reading this!

````

---

## 🧪 Step-by-Step Implementation

### ✅ Step 1: Import Required Libraries

```python
import spotipy
from spotipy.oauth2 import SpotifyOAuth
import pandas as pd
import matplotlib.pyplot as plt
````

---

### 🔐 Step 2: Set Up Spotify Authentication

```python
sp_oauth = SpotifyOAuth(
    client_id="your_client_id",            # Replace with your actual client ID
    client_secret="your_client_secret",    # Replace with your actual client secret
    redirect_uri="http://127.0.0.1:8080/callback",
    scope="user-top-read",
    open_browser=False
)
```

---

### 🌐 Step 3: Authorize Access and Get Token

```python
auth_url = sp_oauth.get_authorize_url()
print("Go to this URL and authorize:", auth_url)

redirect_response = input("Paste the full redirect URL here: ")

code = sp_oauth.parse_response_code(redirect_response)
token_info = sp_oauth.get_access_token(code)
access_token = token_info['access_token']
```

---

### 🔁 Step 4: Create Spotify Client

```python
sp = spotipy.Spotify(auth=access_token)
```

---

### 🎧 Step 5: Fetch Your Top 10 Tracks

```python
top_tracks = sp.current_user_top_tracks(limit=10)
```

---

### 📊 Step 6: Structure the Data into a DataFrame

```python
data = []
for track in top_tracks['items']:
    data.append([
        track['name'],
        track['artists'][0]['name'],
        track['album']['name'],
        track['popularity']
    ])

df = pd.DataFrame(data, columns=['Name', 'Artist', 'Album', 'Popularity'])
```

---

### 💾 Step 7: Export to CSV

```python
df.to_csv("your_spotify_top_tracks.csv", index=False)
print("✅ Data saved to your_spotify_top_tracks.csv")
```

---

### 📈 Step 8: Visualize with Matplotlib

```python
plt.figure(figsize=(10, 6))
plt.barh(df['Name'], df['Popularity'], color='skyblue')
plt.xlabel('Popularity Score')
plt.title('🎧 Top 10 Spotify Tracks')
plt.gca().invert_yaxis()
plt.tight_layout()
plt.show()
```

---

## ✅ Sample Output (Console)

```
🎵 Your Top Tracks:
1. VERY NICE by SEVENTEEN
2. God of Music by SEVENTEEN
...
```

---

## 🧠 Learnings

* Hands-on experience with Spotify API
* Implemented OAuth2 authorization flow
* Created and exported structured data using Pandas
* Built a clean bar chart visualization in Matplotlib

---

## 📌 Next Steps

* Add audio features (e.g., danceability, energy, tempo)
* Analyze genre distribution of top tracks
* Build an interactive dashboard using Plotly or Streamlit

---

## 📎 References

* [Spotify Web API](https://developer.spotify.com/documentation/web-api/)
* [Spotipy GitHub](https://github.com/plamere/spotipy)


