# 🎵 Spotify Top Tracks Data Analysis
# Author: Sri Durga Bhavani Gude
# This project uses the Spotify Web API to fetch your top tracks, save them as a CSV, and visualize them.

# -----------------------------------------
# STEP 1: IMPORT LIBRARIES
# -----------------------------------------
import spotipy
from spotipy.oauth2 import SpotifyOAuth
import pandas as pd
import matplotlib.pyplot as plt

# -----------------------------------------
# STEP 2: SET UP SPOTIFY AUTHENTICATION
# -----------------------------------------
# This connects your Python script to your Spotify account
sp_oauth = SpotifyOAuth(
    client_id="your_client_id",              # replace with your actual client ID
    client_secret="your_client_secret",      # replace with your actual client secret
    redirect_uri="http://127.0.0.1:8080/callback",
    scope="user-top-read",
    open_browser=False
)

# -----------------------------------------
# STEP 3: AUTHORIZE AND GET ACCESS TOKEN
# -----------------------------------------
# You'll need to paste the redirected URL after logging in to Spotify
auth_url = sp_oauth.get_authorize_url()
print("Go to this URL and authorize:", auth_url)
redirect_response = input("Paste the full redirect URL here: ")

code = sp_oauth.parse_response_code(redirect_response)
token_info = sp_oauth.get_access_token(code)
access_token = token_info['access_token']

# -----------------------------------------
# STEP 4: CREATE SPOTIFY CLIENT
# -----------------------------------------
sp = spotipy.Spotify(auth=access_token)

# -----------------------------------------
# STEP 5: FETCH YOUR TOP TRACKS
# -----------------------------------------
top_tracks = sp.current_user_top_tracks(limit=10)

# -----------------------------------------
# STEP 6: STRUCTURE DATA INTO A DATAFRAME
# -----------------------------------------
data = []
for track in top_tracks['items']:
    data.append([
        track['name'],
        track['artists'][0]['name'],
        track['album']['name'],
        track['popularity']
    ])

df = pd.DataFrame(data, columns=['Name', 'Artist', 'Album', 'Popularity'])

# -----------------------------------------
# STEP 7: EXPORT TO CSV
# -----------------------------------------
df.to_csv("your_spotify_top_tracks.csv", index=False)
print("✅ Data saved to your_spotify_top_tracks.csv")

# -----------------------------------------
# STEP 8: VISUALIZE WITH MATPLOTLIB
# -----------------------------------------
plt.figure(figsize=(10, 6))
plt.barh(df['Name'], df['Popularity'], color='skyblue')
plt.xlabel('Popularity Score')
plt.title('🎧 Top 10 Spotify Tracks')
plt.gca().invert_yaxis()  # Highest popularity at the top
plt.tight_layout()
plt.show()
