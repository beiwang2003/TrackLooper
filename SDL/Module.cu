# include "Module.cuh"
std::map <unsigned int, unsigned int> *SDL::detIdToIndex;

void SDL::createModulesInUnifiedMemory(struct modules& modulesInGPU,unsigned int nModules)
{
    /* modules stucture object will be created in Event.cu*/
    cudaMallocManaged(&(modulesInGPU.detIds),nModules * sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.moduleMap,nModules * 40 * sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.nConnectedModules,nModules * sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.drdzs,nModules * sizeof(float));
    cudaMallocManaged(&modulesInGPU.slopes,nModules * sizeof(float));
    cudaMallocManaged(&modulesInGPU.nModules,sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.nLowerModules,sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.layers,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.rings,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.modules,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.rods,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.subdets,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.sides,nModules * sizeof(short));
    cudaMallocManaged(&modulesInGPU.isInverted, nModules * sizeof(bool));
    cudaMallocManaged(&modulesInGPU.isLower, nModules * sizeof(bool));

    cudaMallocManaged(&modulesInGPU.hitRanges,nModules * 2 * sizeof(int));
    cudaMallocManaged(&modulesInGPU.mdRanges,nModules * 2 * sizeof(int));
    cudaMallocManaged(&modulesInGPU.segmentRanges,nModules * 2 * sizeof(int));
    cudaMallocManaged(&modulesInGPU.trackletRanges,nModules * 2 * sizeof(int));
    cudaMallocManaged(&modulesInGPU.tripletRanges,nModules * 2 * sizeof(int));
    cudaMallocManaged(&modulesInGPU.trackCandidateRanges, nModules * 2 * sizeof(int));

    cudaMallocManaged(&modulesInGPU.moduleType,nModules * sizeof(ModuleType));
    cudaMallocManaged(&modulesInGPU.moduleLayerType,nModules * sizeof(ModuleLayerType));

    *modulesInGPU.nModules = nModules;

}
void SDL::createModulesInExplicitMemory(struct modules& modulesInGPU,unsigned int nModules)
{
    /* modules stucture object will be created in Event.cu*/
    cudaMalloc(&(modulesInGPU.detIds),nModules * sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.moduleMap,nModules * 40 * sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.nConnectedModules,nModules * sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.drdzs,nModules * sizeof(float));
    cudaMalloc(&modulesInGPU.slopes,nModules * sizeof(float));
    cudaMalloc(&modulesInGPU.nModules,sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.nLowerModules,sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.layers,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.rings,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.modules,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.rods,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.subdets,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.sides,nModules * sizeof(short));
    cudaMalloc(&modulesInGPU.isInverted, nModules * sizeof(bool));
    cudaMalloc(&modulesInGPU.isLower, nModules * sizeof(bool));

    cudaMalloc(&modulesInGPU.hitRanges,nModules * 2 * sizeof(int));
    cudaMalloc(&modulesInGPU.mdRanges,nModules * 2 * sizeof(int));
    cudaMalloc(&modulesInGPU.segmentRanges,nModules * 2 * sizeof(int));
    cudaMalloc(&modulesInGPU.trackletRanges,nModules * 2 * sizeof(int));
    cudaMalloc(&modulesInGPU.tripletRanges,nModules * 2 * sizeof(int));
    cudaMalloc(&modulesInGPU.trackCandidateRanges, nModules * 2 * sizeof(int));

    cudaMalloc(&modulesInGPU.moduleType,nModules * sizeof(ModuleType));
    cudaMalloc(&modulesInGPU.moduleLayerType,nModules * sizeof(ModuleLayerType));

    cudaMemcpy(modulesInGPU.nModules,&nModules,sizeof(unsigned int),cudaMemcpyHostToDevice);
    //cudaMemset(modulesInGPU.nModules,nModules,sizeof(unsigned int));
    //*modulesInGPU.nModules = nModules;
    //*modulesInGPU.nModules = nModules;

}

void SDL::freeModulesInUnifiedMemory(struct modules& modulesInGPU)
{
  cudaFree(modulesInGPU.detIds);
  cudaFree(modulesInGPU.moduleMap);
  cudaFree(modulesInGPU.nConnectedModules);
  cudaFree(modulesInGPU.drdzs);
  cudaFree(modulesInGPU.slopes);
  cudaFree(modulesInGPU.nModules);
  cudaFree(modulesInGPU.nLowerModules);
  cudaFree(modulesInGPU.layers);
  cudaFree(modulesInGPU.rings);
  cudaFree(modulesInGPU.modules);
  cudaFree(modulesInGPU.rods);
  cudaFree(modulesInGPU.subdets);
  cudaFree(modulesInGPU.sides);
  cudaFree(modulesInGPU.isInverted);
  cudaFree(modulesInGPU.isLower);
  cudaFree(modulesInGPU.hitRanges);
  cudaFree(modulesInGPU.mdRanges);
  cudaFree(modulesInGPU.segmentRanges);
  cudaFree(modulesInGPU.trackletRanges);
  cudaFree(modulesInGPU.tripletRanges);
  cudaFree(modulesInGPU.trackCandidateRanges);
  cudaFree(modulesInGPU.moduleType);
  cudaFree(modulesInGPU.moduleLayerType);
  cudaFree(modulesInGPU.lowerModuleIndices);
  cudaFree(modulesInGPU.reverseLookupLowerModuleIndices);
}

void SDL::createLowerModuleIndexMapExplicit(struct modules& modulesInGPU, unsigned int nLowerModules, unsigned int nModules,bool* isLower)
{
    //FIXME:some hacks to get the pixel module in the lower modules index without incrementing nLowerModules counter!
    //Reproduce these hacks in the explicit memory for identical results (or come up with a better method)
    unsigned int* lowerModuleIndices;
    int* reverseLookupLowerModuleIndices;
    cudaMallocHost(&lowerModuleIndices,(nLowerModules + 1) * sizeof(unsigned int));
    cudaMallocHost(&reverseLookupLowerModuleIndices,nModules * sizeof(int));

    unsigned int lowerModuleCounter = 0;
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); it++)
    {
        unsigned int index = it->second;
        unsigned int detId = it->first;
        if(isLower[index])
        {
            lowerModuleIndices[lowerModuleCounter] = index;
            reverseLookupLowerModuleIndices[index] = lowerModuleCounter;
            lowerModuleCounter++;
        }
        else
        {
           reverseLookupLowerModuleIndices[index] = -1;
        }
    }
    //hacky stuff "beyond the index" for the pixel module. nLowerModules will *NOT* cover the pixel module!
    lowerModuleIndices[nLowerModules] = (*detIdToIndex)[1];
    reverseLookupLowerModuleIndices[(*detIdToIndex)[1]] = nLowerModules;
    cudaMalloc(&modulesInGPU.lowerModuleIndices,(nLowerModules + 1) * sizeof(unsigned int));
    cudaMalloc(&modulesInGPU.reverseLookupLowerModuleIndices,nModules * sizeof(int));
    cudaMemcpy(modulesInGPU.lowerModuleIndices,lowerModuleIndices,sizeof(unsigned int)*(nLowerModules+1),cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.reverseLookupLowerModuleIndices,reverseLookupLowerModuleIndices,sizeof(int)*nModules,cudaMemcpyHostToDevice);
   

}
void SDL::createLowerModuleIndexMap(struct modules& modulesInGPU, unsigned int nLowerModules, unsigned int nModules)
{
    //FIXME:some hacks to get the pixel module in the lower modules index without incrementing nLowerModules counter!
    //Reproduce these hacks in the explicit memory for identical results (or come up with a better method)
    cudaMallocManaged(&modulesInGPU.lowerModuleIndices,(nLowerModules + 1) * sizeof(unsigned int));
    cudaMallocManaged(&modulesInGPU.reverseLookupLowerModuleIndices,nModules * sizeof(int));

    unsigned int lowerModuleCounter = 0;
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); it++)
    {
        unsigned int index = it->second;
        unsigned int detId = it->first;
        if(modulesInGPU.isLower[index])
        {
            modulesInGPU.lowerModuleIndices[lowerModuleCounter] = index;
            modulesInGPU.reverseLookupLowerModuleIndices[index] = lowerModuleCounter;
            lowerModuleCounter++;
        }
        else
        {
            modulesInGPU.reverseLookupLowerModuleIndices[index] = -1;
        }
    }
    //hacky stuff "beyond the index" for the pixel module. nLowerModules will *NOT* cover the pixel module!
    modulesInGPU.lowerModuleIndices[nLowerModules] = (*detIdToIndex)[1];
    modulesInGPU.reverseLookupLowerModuleIndices[(*detIdToIndex)[1]] = nLowerModules;

}

void SDL::loadModulesFromFile(struct modules& modulesInGPU, unsigned int& nModules)
{
    detIdToIndex = new std::map<unsigned int, unsigned int>;

    /*modules structure object will be created in Event.cu*/
    /* Load the whole text file into the unordered_map first*/

    std::ifstream ifile;
    ifile.open("data/centroid.txt");
    if(!ifile.is_open())
    {
        std::cout<<"ERROR! module list file not present!"<<std::endl;
    }
    std::string line;
    unsigned int counter = 0;
    
    while(std::getline(ifile,line))
    {
        std::stringstream ss(line);
        std::string token;
        bool flag = 0;

        while(std::getline(ss,token,','))
        {
            if(flag == 1) break;
            (*detIdToIndex)[stoi(token)] = counter;
            flag = 1;
            counter++;
        }
    }
    //FIXME:MANUAL INSERTION OF PIXEL MODULE!
    (*detIdToIndex)[1] = counter; //pixel module is the last module in the module list
    counter++;
    nModules = counter;
    std::cout<<"Number of modules = "<<nModules<<std::endl;
#ifdef Explicit_Module
    createModulesInExplicitMemory(modulesInGPU,nModules);
    unsigned int* lowerModuleCounter;// = 0;
    cudaMallocHost(&lowerModuleCounter,sizeof(unsigned int));

    unsigned int* host_detIds;
    short* host_layers;
    short* host_rings;
    short* host_rods;
    short* host_modules;
    short* host_subdets;
    short* host_sides;
    bool* host_isInverted;
    bool* host_isLower;
    ModuleType* host_moduleType;
    ModuleLayerType* host_moduleLayerType;
    float* host_slopes;
    float* host_drdzs;
    cudaMallocHost(&host_detIds,sizeof(unsigned int)*nModules);
    cudaMallocHost(&host_layers,sizeof(short)*nModules);
    cudaMallocHost(&host_rings,sizeof(short)*nModules);
    cudaMallocHost(&host_rods,sizeof(short)*nModules);
    cudaMallocHost(&host_modules,sizeof(short)*nModules);
    cudaMallocHost(&host_subdets,sizeof(short)*nModules);
    cudaMallocHost(&host_sides,sizeof(short)*nModules);
    cudaMallocHost(&host_isInverted,sizeof(bool)*nModules);
    cudaMallocHost(&host_isLower,sizeof(bool)*nModules);
    cudaMallocHost(&host_moduleType,sizeof(ModuleType)*nModules);
    cudaMallocHost(&host_moduleLayerType,sizeof(ModuleLayerType)*nModules);
    cudaMallocHost(&host_slopes,sizeof(float)*nModules);
    cudaMallocHost(&host_drdzs,sizeof(float)*nModules);
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); it++)
    {
        unsigned int detId = it->first;
        unsigned int index = it->second;
        host_detIds[index] = detId;
        if(detId == 1)
        {
            host_layers[index] = 0;
            host_rings[index] = 0;
            host_rods[index] = 0;
            host_modules[index] = 0;
            host_subdets[index] = SDL::InnerPixel;
            host_sides[index] = 0;
            host_isInverted[index] = 0;
            host_isLower[index] = false;
            host_moduleType[index] = PixelModule;
            host_moduleLayerType[index] = SDL::InnerPixelLayer;
            host_slopes[index] = 0;
            host_drdzs[index] = 0;
        }
        else
        {
            unsigned short layer,ring,rod,module,subdet,side;
            setDerivedQuantities(detId,layer,ring,rod,module,subdet,side);
            host_layers[index] = layer;
            host_rings[index] = ring;
            host_rods[index] = rod;
            host_modules[index] = module;
            host_subdets[index] = subdet;
            host_sides[index] = side;

            host_isInverted[index] = modulesInGPU.parseIsInverted(index,subdet, side,module,layer);
            host_isLower[index] = modulesInGPU.parseIsLower(index, host_isInverted[index], detId);

            host_moduleType[index] = modulesInGPU.parseModuleType(index, subdet, layer, ring);
            host_moduleLayerType[index] = modulesInGPU.parseModuleLayerType(index, host_moduleType[index],host_isInverted[index],host_isLower[index]);

            host_slopes[index] = (subdet == Endcap) ? endcapGeometry.getSlopeLower(detId) : tiltedGeometry.getSlope(detId);
            host_drdzs[index] = (subdet == Barrel) ? tiltedGeometry.getDrDz(detId) : 0;
        }
          lowerModuleCounter[0] += host_isLower[index];
    }

//    cudaMemset(modulesInGPU.nLowerModules,lowerModuleCounter,sizeof(unsigned int));
    cudaMemcpy(modulesInGPU.nLowerModules,lowerModuleCounter,sizeof(unsigned int),cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.detIds,host_detIds,nModules*sizeof(unsigned int),cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.layers,host_layers,nModules*sizeof(short),cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.rings,host_rings,sizeof(short)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.rods,host_rods,sizeof(short)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.modules,host_modules,sizeof(short)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.subdets,host_subdets,sizeof(short)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.sides,host_sides,sizeof(short)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.isInverted,host_isInverted,sizeof(bool)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.isLower,host_isLower,sizeof(bool)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.moduleType,host_moduleType,sizeof(ModuleType)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.moduleLayerType,host_moduleLayerType,sizeof(ModuleLayerType)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.slopes,host_slopes,sizeof(float)*nModules,cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.drdzs,host_drdzs,sizeof(float)*nModules,cudaMemcpyHostToDevice);
//    cudaFreeHost(host_layers);
//    cudaFreeHost(host_rings);
//    cudaFreeHost(host_rods);
//    cudaFreeHost(host_modules);
//    cudaFreeHost(host_subdets);
//    cudaFreeHost(host_sides);
//    cudaFreeHost(host_isInverted);
//    cudaFreeHost(host_isLower);
//    cudaFreeHost(host_moduleType);
//    cudaFreeHost(host_moduleLayerType);
//    cudaFreeHost(host_slopes);
//    cudaFreeHost(host_drdzs);
    std::cout<<"number of lower modules (without fake pixel module)= "<<lowerModuleCounter[0]<<std::endl;
    createLowerModuleIndexMapExplicit(modulesInGPU,lowerModuleCounter[0], nModules,host_isLower);
    fillConnectedModuleArrayExplicit(modulesInGPU,nModules);
    resetObjectRanges(modulesInGPU,nModules);

#else
    createModulesInUnifiedMemory(modulesInGPU,nModules);
    unsigned int lowerModuleCounter = 0;
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); it++)
    {
        unsigned int detId = it->first;
        unsigned int index = it->second;
        modulesInGPU.detIds[index] = detId;
//        printf("detId %u\n",detId);
        if(detId == 1)
        {
            modulesInGPU.layers[index] = 0;
            modulesInGPU.rings[index] = 0;
            modulesInGPU.rods[index] = 0;
            modulesInGPU.modules[index] = 0;
            modulesInGPU.subdets[index] = SDL::InnerPixel;
            modulesInGPU.sides[index] = 0;
            modulesInGPU.isInverted[index] = 0;
            modulesInGPU.isLower[index] = false;
            modulesInGPU.moduleType[index] = PixelModule;
            modulesInGPU.moduleLayerType[index] = SDL::InnerPixelLayer;
            modulesInGPU.slopes[index] = 0;
            modulesInGPU.drdzs[index] = 0;
        }
        else
        {
            unsigned short layer,ring,rod,module,subdet,side;
            setDerivedQuantities(detId,layer,ring,rod,module,subdet,side);
            modulesInGPU.layers[index] = layer;
            modulesInGPU.rings[index] = ring;
            modulesInGPU.rods[index] = rod;
            modulesInGPU.modules[index] = module;
            modulesInGPU.subdets[index] = subdet;
            modulesInGPU.sides[index] = side;

            modulesInGPU.isInverted[index] = modulesInGPU.parseIsInverted(index);
            modulesInGPU.isLower[index] = modulesInGPU.parseIsLower(index);

            modulesInGPU.moduleType[index] = modulesInGPU.parseModuleType(index);
            modulesInGPU.moduleLayerType[index] = modulesInGPU.parseModuleLayerType(index);

            modulesInGPU.slopes[index] = (subdet == Endcap) ? endcapGeometry.getSlopeLower(detId) : tiltedGeometry.getSlope(detId);
            modulesInGPU.drdzs[index] = (subdet == Barrel) ? tiltedGeometry.getDrDz(detId) : 0;
        }
     // printf("lower(%d): %d\n",index,modulesInGPU.isLower[index]);
        if(modulesInGPU.isLower[index]) lowerModuleCounter++;
    }
    *modulesInGPU.nLowerModules = lowerModuleCounter;
    std::cout<<"number of lower modules (without fake pixel module)= "<<*modulesInGPU.nLowerModules<<std::endl;
    createLowerModuleIndexMap(modulesInGPU,lowerModuleCounter, nModules);
    fillConnectedModuleArray(modulesInGPU,nModules);
    resetObjectRanges(modulesInGPU,nModules);
#endif
}

void SDL::fillConnectedModuleArrayExplicit(struct modules& modulesInGPU, unsigned int nModules)
{
    unsigned int* moduleMap;
    unsigned int* nConnectedModules; 
    cudaMallocHost(&moduleMap,nModules * 40 * sizeof(unsigned int));
    cudaMallocHost(&nConnectedModules,nModules * sizeof(unsigned int));
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); ++it)
    {
        unsigned int detId = it->first;
        unsigned int index = it->second;
        auto& connectedModules = moduleConnectionMap.getConnectedModuleDetIds(detId);
        nConnectedModules[index] = connectedModules.size();
        for(unsigned int i = 0; i< nConnectedModules[index];i++)
        {
            moduleMap[index * 40 + i] = (*detIdToIndex)[connectedModules[i]];
        }
    }
    cudaMemcpy(modulesInGPU.moduleMap,moduleMap,nModules*40*sizeof(unsigned int),cudaMemcpyHostToDevice);
    cudaMemcpy(modulesInGPU.nConnectedModules,nConnectedModules,nModules*sizeof(unsigned int),cudaMemcpyHostToDevice);
}
void SDL::fillConnectedModuleArray(struct modules& modulesInGPU, unsigned int nModules)
{
    for(auto it = (*detIdToIndex).begin(); it != (*detIdToIndex).end(); ++it)
    {
        unsigned int detId = it->first;
        unsigned int index = it->second;
        auto& connectedModules = moduleConnectionMap.getConnectedModuleDetIds(detId);
        modulesInGPU.nConnectedModules[index] = connectedModules.size();
        for(unsigned int i = 0; i< modulesInGPU.nConnectedModules[index];i++)
        {
            modulesInGPU.moduleMap[index * 40 + i] = (*detIdToIndex)[connectedModules[i]];
        }
    }
}

void SDL::setDerivedQuantities(unsigned int detId, unsigned short& layer, unsigned short& ring, unsigned short& rod, unsigned short& module, unsigned short& subdet, unsigned short& side)
{
    subdet = (detId & (7 << 25)) >> 25;
    side = (subdet == Endcap) ? (detId & (3 << 23)) >> 23 : (detId & (3 << 18)) >> 18;
    layer = (subdet == Endcap) ? (detId & (7 << 18)) >> 18 : (detId & (7 << 20)) >> 20;
    ring = (subdet == Endcap) ? (detId & (15 << 12)) >> 12 : 0;
    module = (detId & (127 << 2)) >> 2;
    rod = (subdet == Endcap) ? 0 : (detId & (127 << 10)) >> 10;
}

//auxilliary functions - will be called as needed
bool SDL::modules::parseIsInverted(unsigned int index)
{
    if (subdets[index] == Endcap)
    {
        if (sides[index] == NegZ)
        {
            return modules[index] % 2 == 1;
        }
        else if (sides[index] == PosZ)
        {
            return modules[index] % 2 == 0;
        }
        else
        {
            return 0;
        }
    }
    else if (subdets[index] == Barrel)
    {
        if (sides[index] == Center)
        {
            if (layers[index] <= 3)
            {
                return modules[index] % 2 == 1;
            }
            else if (layers[index] >= 4)
            {
                return modules[index] % 2 == 0;
            }
            else
            {
                return 0;
            }
        }
        else if (sides[index] == NegZ or sides[index] == PosZ)
        {
            if (layers[index] <= 2)
            {
                return modules[index] % 2 == 1;
            }
            else if (layers[index] == 3)
            {
                return modules[index] % 2 == 0;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}
bool SDL::modules::parseIsInverted(unsigned int index, short subdet, short side, short module, short layer)
{
    if (subdet == Endcap)
    {
        if (side == NegZ)
        {
            return module % 2 == 1;
        }
        else if (side == PosZ)
        {
            return module % 2 == 0;
        }
        else
        {
            return 0;
        }
    }
    else if (subdet == Barrel)
    {
        if (side == Center)
        {
            if (layer <= 3)
            {
                return module % 2 == 1;
            }
            else if (layer >= 4)
            {
                return module % 2 == 0;
            }
            else
            {
                return 0;
            }
        }
        else if (side == NegZ or side == PosZ)
        {
            if (layer <= 2)
            {
                return module % 2 == 1;
            }
            else if (layer == 3)
            {
                return module % 2 == 0;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

bool SDL::modules::parseIsLower(unsigned int index, bool isInvertedx, unsigned int detId)
{
    return (isInvertedx) ? !(detId & 1) : (detId & 1);
}
bool SDL::modules::parseIsLower(unsigned int index)
{
    return (isInverted[index]) ? !(detIds[index] & 1) : (detIds[index] & 1);
}

unsigned int SDL::modules::partnerModuleIndex(unsigned int index)
{
    /*We need to ensure modules with successive det Ids are right next to each other
    or we're dead*/
    if(isLower[index])
    {
        return (isInverted[index] ? index - 1: index + 1);
    }
    else
    {
        return (isInverted[index] ? index + 1 : index - 1);
    }
}

SDL::ModuleType SDL::modules::parseModuleType(unsigned int index, short subdet, short layer, short ring)
{
    if(subdet == Barrel)
    {
        if(layer <= 3)
        {
            return PS;
        }
        else
        {
            return TwoS;
        }
    }
    else
    {
        if(layer <= 2)
        {
            if(ring <= 10)
            {
                return PS;
            }
            else
            {
                return TwoS;
            }
        }
        else
        {
            if(ring <= 7)
            {
                return PS;
            }
            else
            {
                return TwoS;
            }
        }
    }
}
SDL::ModuleType SDL::modules::parseModuleType(unsigned int index)
{
    if(subdets[index] == Barrel)
    {
        if(layers[index] <= 3)
        {
            return PS;
        }
        else
        {
            return TwoS;
        }
    }
    else
    {
        if(layers[index] <= 2)
        {
            if(rings[index] <= 10)
            {
                return PS;
            }
            else
            {
                return TwoS;
            }
        }
        else
        {
            if(rings[index] <= 7)
            {
                return PS;
            }
            else
            {
                return TwoS;
            }
        }
    }
}

SDL::ModuleLayerType SDL::modules::parseModuleLayerType(unsigned int index, ModuleType moduleTypex,bool isInvertedx, bool isLowerx)
{
    if(moduleTypex == TwoS)
    {
        return Strip;
    }
    if(isInvertedx)
    {
        if(isLowerx)
        {
            return Strip;
        }
        else
        {
            return Pixel;
        }
    }
    else
   {
        if(isLowerx)
        {
            return Pixel;
        }
        else
        {
            return Strip;
        }
    }
}
SDL::ModuleLayerType SDL::modules::parseModuleLayerType(unsigned int index)
{
    if(moduleType[index] == TwoS)
    {
        return Strip;
    }
    if(isInverted[index])
    {
        if(isLower[index])
        {
            return Strip;
        }
        else
        {
            return Pixel;
        }
    }
    else
   {
        if(isLower[index])
        {
            return Pixel;
        }
        else
        {
            return Strip;
        }
    }
}

void SDL::resetObjectRanges(struct modules& modulesInGPU, unsigned int nModules)
{
#ifdef Explicit_Module
        cudaMemset(modulesInGPU.hitRanges, -1,nModules*2*sizeof(int));
        cudaMemset(modulesInGPU.mdRanges, -1,nModules*2*sizeof(int));
        cudaMemset(modulesInGPU.segmentRanges, -1,nModules*2*sizeof(int));
        cudaMemset(modulesInGPU.trackletRanges, -1,nModules*2*sizeof(int));
        cudaMemset(modulesInGPU.tripletRanges, -1,nModules*2*sizeof(int));
        cudaMemset(modulesInGPU.trackCandidateRanges, -1,nModules*2*sizeof(int));
#else

#pragma omp parallel for default(shared)
    for(size_t i = 0; i<nModules *2; i++)
    {
        modulesInGPU.hitRanges[i] = -1;
        modulesInGPU.mdRanges[i] = -1;
        modulesInGPU.segmentRanges[i] = -1;
        modulesInGPU.trackletRanges[i] = -1;
        modulesInGPU.tripletRanges[i] = -1;
        modulesInGPU.trackCandidateRanges[i] = -1;
    }
#endif
}
