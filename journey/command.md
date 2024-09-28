# useful command

```bash
command:
        docker build -t server .
        docker run -p 127.0.0.1:3000:3000 server:latest

        docker images
        docker container ls
        docker image history server

        docker scout quickview
        docker scout cves local://server:latest
        docker scout recommendations local://server:latest
        docker scout quickview local://server:latest --org <organization>

        docker build -t name:tag .

        $env:EDITOR="code --wait"                        # for powershell
        SET EDITOR="C:\Program Files\Microsoft VS Code"  # for cmd
        rails credentials:edit -e production             # for Windows

        EDITOR="code --wait" rails credentials:edit -e production     # for UNIX-based Operating System

        docker run --rm -it --entrypoint=/bin/bash server
```
