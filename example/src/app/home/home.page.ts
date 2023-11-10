import { Component, OnInit } from '@angular/core';
import { NSD, NetService, NetServiceError } from 'capacitor-plugin-nsd';

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage implements OnInit {

  constructor() {}

  ngOnInit(): void {
    NSD.addListener('onServiceError', (data: NetServiceError) => {
      console.error(data);
    })
    NSD.addListener('onDiscoveryStopped', (data: any) => {
      console.log(data);
    })
    NSD.addListener('onServiceResolved', (data: NetService) => {
      console.log(data);
    })
  }

  findNewtworkService() {
    NSD.startFindNewtworkService({type: "_poncps._tcp", domain: "local"}).then(() => {
      console.log('Start Find Newtwork Service successfully');
    }).catch((error: any) => {
      console.error('Error Start Find Newtwork Service:', error);
    });
  }

  stopNetworkService() {
    NSD.stopNetworkService().then(() => {
      console.log('Stop Nework successfully');
    }).catch((error: any) => {
      console.error('Error Stop Nework discovery:', error);
    });
  }

  getAllNetworkService() {
    NSD.getAllNetworkService().then((data: NetService[]) => {
      console.log('Get All Network Service successfully', data);
    }).catch((error: any) => {
      console.error('Error Get All Network Servic:', error);
    });
  }

}
