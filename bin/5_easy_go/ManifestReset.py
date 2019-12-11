#!/usr/bin/env python

from xml.etree.ElementTree import Element, dump, parse
import sys
import os

COLOR_GR = '\033[1;32m'
COLOR_END = '\033[0m'

rootDir = ""
# =======================================================================================

def main(argv):
    if len(argv) == 2:
    	print ( """Please, input manifest file name 
Examples : 
        ManifestReset.py msm8916 XXXXX.xml"""
	)
    	exit(1)
    try:
        targetChipset = argv[1]
    	targetManifest = argv[2]
        targetPath = init(targetChipset, targetManifest)
        performGitReset(targetPath)
    except Exception as e:
        print COLOR_GR+'[ERROR]:',e,COLOR_END
        sys.exit(1)

def init(targetChipset, targetManifest):
    global rootDir
    rootDir = os.getcwd()
    repoDir = rootDir+'/.repo'
    
    os.environ['MANIFEST_ROOT']=repoDir

    if not os.path.exists(repoDir):
	raise Exception("Cannot find '.repo' directory in current path.\n         Please run this in top folder.")

    manifest_f = os.environ['MANIFEST_ROOT']+'/manifests/'+targetChipset+'/'+targetChipset+'/'+targetManifest
    if not os.path.exists(manifest_f):
       raise Exception("Cannot find Manifest file.\n       Please input correct Manifest file.")
    
    return manifest_f 

def performGitReset(targetPath):
    global rootDir
    targetXML = open(targetPath,'r')
    tree = parse(targetXML)
    root = tree.getroot()
    
    for element in root.findall("project"):
        os.chdir(rootDir);
        try:
            os.chdir(element.get('path'))
        except:
            print element.get('path') + "was not exists"
        os.system("git reset --hard " + element.get('revision'))

main(sys.argv)
