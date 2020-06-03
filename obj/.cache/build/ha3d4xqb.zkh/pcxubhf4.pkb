<!DOCTYPE html>
<!--[if IE]><![endif]-->
<html>
  
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Device status </title>
    <meta name="viewport" content="width=device-width">
    <meta name="title" content="Device status ">
    <meta name="generator" content="docfx 2.54.0.0">
    
    <link rel="shortcut icon" href="../../../../favicon.ico">
    <link rel="stylesheet" href="../../../../styles/docfx.vendor.css">
    <link rel="stylesheet" href="../../../../styles/docfx.css">
    <link rel="stylesheet" href="../../../../styles/main.css">
    <meta property="docfx:navrel" content="../../../../toc.html">
    <meta property="docfx:tocrel" content="../../../toc.html">
    
    <meta property="docfx:rel" content="../../../../">
    
  </head>
  <body data-spy="scroll" data-target="#affix" data-offset="120">
    <div id="wrapper">
      <header>
        
        <nav id="autocollapse" class="navbar navbar-inverse ng-scope" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="../../../../V1/index.html" width="46">
                <img id="logo" src="../../../../V1/main/V1/images/atlas_icon.png" height="46" width="46" alt="OSIsoft Edge System"> 
              </a>
            </div>
            <div class="collapse navbar-collapse" id="navbar">
              <form class="navbar-form navbar-right" role="search" id="search">
                <div class="form-group">
                  <input type="text" class="form-control" id="search-query" placeholder="Search" autocomplete="off">
                </div>
              </form>
            </div>
          </div>
        </nav>
        
        <div class="subnav navbar navbar-default">
          <div class="container hide-when-search" id="breadcrumb">
            <ul class="breadcrumb">
              <li></li>
            </ul>
          </div>
        </div>
      </header>
      <div class="container body-content">
        
        <div id="search-results">
          <div class="search-list"></div>
          <div class="sr-items">
            <p><i class="glyphicon glyphicon-refresh index-loading"></i></p>
          </div>
          <ul id="pagination"></ul>
        </div>
      </div>
      <div role="main" class="container body-content hide-when-search">
        
        <div class="sidenav hide-when-search">
          <a class="btn toc-toggle collapse" data-toggle="collapse" href="#sidetoggle" aria-expanded="false" aria-controls="sidetoggle">Show / Hide Table of Contents</a>
          <div class="sidetoggle collapse" id="sidetoggle">
            <div id="sidetoc"></div>
          </div>
        </div>
        <div class="article row grid-right">
          <div class="col-md-10">
            <article class="content wrap" id="_content" data-uid="DeviceStatus">
<h1 id="device-status" sourcefile="V1/main/V1/Health/Device status.md" sourcestartlinenumber="5" sourceendlinenumber="5">Device status</h1>

<p sourcefile="V1/main/V1/Health/Device status.md" sourcestartlinenumber="7" sourceendlinenumber="7">The device status indicates the health of this component and if it is currently communicating properly with the data source. This time-series data is stored within a PI point or OCS stream, depending on the endpoint type. During healthy steady-state operation, a value of <code>Good</code> is expected.</p>
<table sourcefile="V1/main/V1/Health/Device status.md" sourcestartlinenumber="9" sourceendlinenumber="12">
<thead>
<tr>
<th>Property</th>
<th>Type</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong>Time</strong></td>
<td><code>string</code></td>
<td>Timestamp of the event</td>
</tr>
<tr>
<td><strong>DeviceStatus</strong></td>
<td><code>string</code></td>
<td>The value of the <code>DeviceStatus</code></td>
</tr>
</tbody>
</table>
<p sourcefile="V1/main/V1/Health/Device status.md" sourcestartlinenumber="14" sourceendlinenumber="14">The possible statuses are:</p>
<table sourcefile="V1/main/V1/Health/Device status.md" sourcestartlinenumber="16" sourceendlinenumber="25">
<thead>
<tr>
<th>Status</th>
<th>Meaning</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>Good</code></td>
<td>The component is connected to the data source and it is collecting data.</td>
</tr>
<tr>
<td><code>ConnectedNoData</code></td>
<td>The component is connected to the data source but it is not receiving data from it.</td>
</tr>
<tr>
<td><code>AttemptingFailover</code></td>
<td>The adapter is attempting to failover.</td>
</tr>
<tr>
<td><code>Starting</code></td>
<td>The component is currently in the process of starting up and is not yet connected to the data source.</td>
</tr>
<tr>
<td><code>DeviceInError</code></td>
<td>The component encountered an error either while connecting to the data source or attempting to collect data.</td>
</tr>
<tr>
<td><code>Shutdown</code></td>
<td>The component is either in the process of shutting down or has finished.</td>
</tr>
<tr>
<td><code>Removed</code></td>
<td>The adapter component has been removed and will no longer collect data.</td>
</tr>
<tr>
<td><code>NotConfigured</code></td>
<td>The adapter component has been created but is not yet configured.</td>
</tr>
</tbody>
</table>
</article>
          </div>
          
          <div class="hidden-sm col-md-2" role="complementary">
            <div class="sideaffix">
              <div class="contribution">
                <ul class="nav">
                  <li>
                    <a href="https://github.com/osisoft/OSIsoft-Adapter/blob/master/V1/Health/Device status.md/#L1" class="contribution-link">Improve this Doc</a>
                  </li>
                </ul>
              </div>
              <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix" id="affix">
              <!-- <p><a class="back-to-top" href="#top">Back to top</a><p> -->
              </nav>
            </div>
          </div>
        </div>
      </div>
      
      <footer>
        <div class="grad-bottom"></div>
        <div class="footer">
          <div class="container">
            <span class="pull-right">
              <a href="#top">Back to top</a>
            </span>
            
            <span>© 2020 - OSIsoft, LLC.</span>
          </div>
        </div>
      </footer>
    </div>
    
    <script type="text/javascript" src="../../../../styles/docfx.vendor.js"></script>
    <script type="text/javascript" src="../../../../styles/docfx.js"></script>
    <script type="text/javascript" src="../../../../styles/main.js"></script>
  </body>
</html>