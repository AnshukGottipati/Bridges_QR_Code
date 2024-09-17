#include <iostream>
#include <string>
#include <queue>
#include "Bridges.h"
#include "DataSource.h"
#include "data_src/ActorMovieIMDB.h"

using namespace bridges;

int main(int argc, char **argv) {

	// create Bridges object
	Bridges bridges(21, "Agottipa", "419202861914");

	// set title
	bridges.setTitle("QR Code Maker");
	//This is the link 
	string link = "https://bridgesuncc.github.io/";

	//Default Color is green
	Color black(0,0,0);
	Color white(255,255,255);
	ColorGrid cg(21,21,white);


	//Top left positioning square
	
	for(int i = 0; i < 7 ;i++){
		for(int j = 0; j < 7 ;j++){
			if(i == 0 || i == 6){
				cg.set(i,j,black);
			} else if(i == 1 || i == 5){
				cg.set(i,0,black);
				cg.set(i,6,black);
			} else{
				if(j != 1 && j != 5)
					cg.set(i,j,black);
			}
		}
		
	}

	//Top Right positioning square
	for(int i = 0; i < 7 ;i++){
		for(int j = 14; j < 21 ;j++){
			if(i == 0 || i == 6){
				cg.set(i,j,black);
			} else if(i == 1 || i == 5){
				cg.set(i,14,black);
				cg.set(i,20,black);
			} else{
				if(j != 15 && j != 19)
					cg.set(i,j,black);
			}
		}
		
	}

	//Bottom left positoning square
	for(int i = 14; i < 21 ;i++){
		for(int j = 0; j < 7 ;j++){
			if(i == 14 || i == 20){
				cg.set(i,j,black);
			} else if(i == 15 || i == 19){
				cg.set(i,0,black);
				cg.set(i,6,black);
			} else{
				if(j != 1 && j != 5)
					cg.set(i,j,black);
			}
		}
		
	}


	bridges.setDataStructure(cg);
	bridges.visualize();

}

