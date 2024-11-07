function smx3-changes
  cd /Users/amrk/IdeaProjects/securemx/smx3
  smx-build -l | grep java | cut -d ' ' -f 3
end
