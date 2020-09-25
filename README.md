# httpimg
Headless screenshot tool.  
Yet another utility to take screenshots of http servers. Useful in recon and bug bounty.  
You can run the script independently or as a docker container.   
The script is POSIX-compliant and depends on curl and wkhtmltoimage. The docker image is self-contained.   

# Basic Usage
## Running the script
```
cat targets.txt | httpimg
```
```
# or redir file from stdin
httpimg < targets.txt

# or pass file as argument
httpimg targets.txt
```

## Running the Docker container
```
docker run --rm -it -v $(pwd):/screenshots wfnintr/httpimg targets.txt
```
The file must be newline deliminated. Port 80 is assumed by default, otherwise you must specify like so: `http://host:port`. Or maybe actually i'll patch that in later

# Example output
```
$ httpimg < targets.txt
screenshotting wfnintr.net...OK
screenshotting 66.218.84.137...OK
screenshotting 74.6.136.150...OK
screenshotting 98.137.11.143...OK
screenshotting wfnintr.net...OK
screenshotting ds-global3.l7.search.ystg1.b.yahoo.com...OK
screenshotting src.g03.yahoodns.net...OK
generating final html report...done
```

In the current working directory, you will find `*.png` files for each host screenshotted successfully and a `screenshots.html` report.

![example](http://wfnintr.net/images/httpimg.png)

---

This is quite minimal. ( i think..)  
I was originally inspired by the [http-screenshot.nse](https://github.com/SpiderLabs/Nmap-Tools/blob/master/NSE/http-screenshot.nse) script which just utilizes `wkhtmltoimage` to take a screenshot of a webpage. I've done the same thing here.  
[wkhtmlimage](https://wkhtmltopdf.org/) is much smaller to install than chromium, chrome devtools, firefox or whatever other dependencies are necessary for tools like [aquatone](https://github.com/michenriksen/aquatone), [go-stare](https://github.com/dwisiswant0/go-stare) and the like.   
I just wrote a quick function to iterate over a list of domains, running wkhtmltoimage on each one, with a subsequent function to link all the images into a single html report.
Then I packed it all into a docker container and that's all there was to it.  It's not THAT small however, `wkhtmltopdf` pulls in a lot of dependencies and i had to base it off of debian:bullseye-slim for now.alpine in the future, if possible.  

