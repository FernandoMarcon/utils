import youtube_dl
import os

# Get the YouTube video link from the user
video_url = input("Enter the YouTube video link: ")

# Set the options for downloading the subtitles
ydl_opts = {
    'writesubtitles': True,
    'subtitleslangs': ['en'],  # Default language is English
    'skip_download': True,
}

# Download the subtitles
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    info_dict = ydl.extract_info(video_url, download=False)
    video_title = info_dict.get('title', None)
    video_id = info_dict.get('id', None)
    subtitles_langs = ydl.extract_info(video_url, download=False)['subtitles'].keys()

    # Check if the video is in Portuguese
    if 'pt' in subtitles_langs:
        ydl_opts['subtitleslangs'] = ['pt']  # Set language to Portuguese

    subtitles = ydl.extract_info(video_url, download=False)['subtitles'][ydl_opts['subtitleslangs'][0]]

# Save the subtitles to a file
file_name = f"{video_title}_{video_id}.srt"
file_path = os.path.join("/home/fm/data/srt", file_name)
with open(file_path, 'w', encoding='utf-8') as f:
    f.write(subtitles)

print(f"Subtitles downloaded and saved to {file_path}")
