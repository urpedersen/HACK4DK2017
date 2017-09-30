
Resolution 1920x1080

```bash
ffmpeg -r 30 -f image2 -s 1920x1080 -i img/%04d.png -vcodec libx264 -crf 25  -pix_fmt yuv420p movie.mp4
```
