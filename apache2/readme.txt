so I think I have apache working as a proxy https server for dot net server.
dotnet server serves unencrtypted traffic on localhost port 8080, and apache
listens on 443 for encrypted traffic. grep 443 ./ -Irn to see how that proxy
stuff is setup. As for the https cert, I think it was called cert zero. But it
was a free initiative to get all internet traffic certified, and it was
super easy once i found it, where as all other solutions were too hard for me to get.
