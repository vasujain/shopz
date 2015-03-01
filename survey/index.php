<?php ?>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Take A Survey for Me, Please?</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/agency.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="page-top" class="index">

    <!-- Navigation -->
    <nav class="navbar navbar-default" style="background-color: #f4f4ee; margin-bottom: 0px !important;">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="row">
                <div class="col-lg-5 text-center"></div>
                <div class="col-lg-2 text-center">
                    <div class="navbar-header page-scroll">
                        <a class="navbar-brand page-scroll" href="#page-top" style="font-size: 5em !important;">ShopZ</a>
                    </div>
                </div>
                <div class="col-lg-5 text-center"></div>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Team Section -->
    <section id="team1" class="bg-light-gray" style="padding-top: 10px !important; padding-bottom: 10px !important;" >
        <div class="container">

            <div class="row" style="margin-top: 50px !important; margin-bottom: 10px !important;">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-2">
                    <div class="team-member">
                        <img src="img/team/1.jpg" class="img-responsive img-circle" alt="">
                        <h4>Hello, Jessica Day</h4>
                        <p class="text-muted"></p>

                    </div>
                </div>
                <?php
                    require '../macys/Macys.php';
                    $macysObj = new Macys();
                    $prod = json_decode($macysObj->searchCatalog($_GET['pid']));
                    // print_r($prod->searchresultgroups[0]->products->product[0]);
                ?>
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="<?php echo $prod->searchresultgroups[0]->products->product[0]->image[0]->imageurl; ?>" class="img-responsive img-square" alt="">
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="team-member">
                        <h3>
                            <?php
                                echo $prod->searchresultgroups[0]->products->product[0]->summary->brand . ", " . $prod->searchresultgroups[0]->products->product[0]->summary->producttype ;
                            ?>
                        </h3>
                        <h4>
                            <?php
                            echo $prod->searchresultgroups[0]->products->product[0]->summary->name ;
                            ?>
                            <p class="text-muted" style="padding-top: 20px; font-size: 20px"><b>$
                                    <?php
                                        if(isset($prod->searchresultgroups[0]->products->product[0]->price->regular->value)) {
                                            echo $prod->searchresultgroups[0]->products->product[0]->price->regular->value;
                                        } else {
                                            echo 49.99;
                                        }
                                    ?>
                                </b>
                            </p>
                            <p>
                                <a href="<?php echo $prod->searchresultgroups[0]->products->product[0]->summary->producturl;?>">Product URL</a>
                            </p>
                        </h4>
                        <p class="text-muted"></p>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 10px !important; margin-bottom: 10px !important;">
                <div class="col-lg-4 text-center"></div>
                <div class="col-lg-4 text-center">
                    <h3 class="section-subheading text-muted" style="font-size: 22px; !important; margin-bottom: 1px !important;">Jess Wants Your Help,</h3>
                </div>
                <div class="col-lg-4 text-center"></div>
            </div>

            <div class="row">
                <div class="col-lg-8 col-lg-offset-2 text-center">
                    <p class="large text-muted">"I'm interested in purchasing this <?php echo $prod->searchresultgroups[0]->products->product[0]->summary->producttype; ?>, Would you recommend them?"</p>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
    </section>
    <section id="team2" class="bg-light-gray" style="padding-top: 10px !important; padding-bottom: 10px !important;" >
        <form action="../firebase/recommendation.php?pid=<?php echo $_GET['pid']; ?>" method="post">
            <div class="row">
                <div class="col-md-5"></div>
                <div class="col-md-3">
                    <div class="form-group">
                        <input id="radio1" name="flag" value="yes" checked="" type="radio">
                        <label for="radio1" style="padding-right: 30px;padding-left: 30px;" class="fa fa-thumbs-o-up bigicon"> </label>
                        <input id="radio2" name="flag" value="no" checked="" type="radio">
                        <label for="radio2" style="padding-right: 30px;padding-left: 30px;"  class="fa fa-thumbs-o-down bigicon"></label>

                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
            <div class="clearfix"></div>
            <div class="clearfix"></div>
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <div class="form-group">
                            <textarea class="form-control" placeholder="Your Message *" id="messageBox" name="messageBox"></textarea>
                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                <div class="col-md-3"></div>
            </div>


            <div class="row">
                <div class="col-md-4"></div>
                <style>
                    .col-md-4 {
                        width: 32.33333333% !important;
                    }
                </style>
                <div class="col-md-4">
                    <div class="form-group">
                        <div id="success"></div>
                        <button type="submit" class="btn btn-xl">Share your Recommendation</button>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
            </div>
        </form>
    </section>
    
    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright">Copyright &copy; ShopZ 2015</span>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a href="#">Privacy Policy</a>
                        </li>
                        <li><a href="#">Terms of Use</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    
    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
    <script src="js/classie.js"></script>
    <script src="js/cbpAnimatedHeader.js"></script>

    <!-- Contact Form JavaScript -->
<!--    <script src="js/jqBootstrapValidation.js"></script>-->
<!--    <script src="js/contact_me.js"></script>-->

    <!-- Custom Theme JavaScript -->
    <script src="js/agency.js"></script>

</body>

</html>
